## 9 장 Kubernetes 시작하기



이전 장에서 우리는 애플리케이션을 배포하기 위해 도커를 사용하여 컨테이너로 애플리케션을 관리하는 방법을 학습하였다. 리눅스 컨테이너 기술 및 도커와 함께 컨테이너를 통한 애플리케이션을 관리하는 접근방식은 인프라스트럭처로부터 애플리케이션이 자유로워질 수 있는 새로운 패러다임으로 자리매김하게 되었다.

컨테이너는 가상머신과 유사하지만 격리 속성을 완화하여 애플리케이션 간에 운영체제(OS)를 공유한다. 그러므로 컨테이너는 기동 시간 및 자원 효율성면에서 물리적 서버와 가상머신의 장점을 모두 채택했다고 볼 수 있다. 가상머신과 마찬가지로 컨테이너에는 자체 파일 시스템, CPU 점유율, 메모리, 프로세스 공간 등이 있다. 기본 인프라와의 종속성을 끊었기 때문에, 클라우드나 운영체제 배포본에 모두 이식할 수 있다.

컨테이너는 다음과 같은 추가적인 혜택을 제공하기 때문에 인기가 있다.

- 기민한 애플리케이션 생성과 배포
  - 가상머신 이미지를 사용하는 것에 비해 컨테이너 이미지 생성이 보다 쉽고 효율적이다.

- 지속적인 개발, 통합 및 배포
  - 안정적이고 주기적으로 컨테이너 이미지를 빌드해서 배포할 수 있고 (이미지의 불변성 덕에) 빠르고 효율적으로 롤백할 수 있다.

- 개발과 운영의 관심사 분리
  - 배포 시점이 아닌 빌드/릴리스 시점에 애플리케이션 컨테이너 이미지를 만들기 때문에, 애플리케이션이 인프라스트럭처에서 분리된다.

- 가시성(Observability)
  - 운영체제 수준의 정보와 메트릭에 머무르지 않고, 애플리케이션의 헬스와 그 밖의 시그널을 볼 수 있다.

- 개발, 테스팅 및 운영 환경에 걸친 일관성(Consistency)
  - 랩탑에서도 클라우드에서와 동일하게 구동된다.

- 클라우드 및 운영체제 배포판 간 이식성(Portability)
  - 우분투(Ubuntu), 레드햇 기업형 리눅스(RHEL), CoreOS, 온-프레미스, 주요 퍼블릭 클라우드와 어디에서든 구동된다.

- 애플리케이션 중심 관리
  - 가상 하드웨어 상에서 운영체제를 실행하는 수준에서 논리적인 리소스를 사용하는 운영체제상에서 애플리케이션을 실행하는 수준으로 추상화 수준이 높아진다.

- 느슨하게 커플되고, 분산되고, 유연하며, 자유로운 마이크로서비스
  - 애플리케이션은 단일 목적의 머신에서 모놀리식 스택으로 구동되지 않고 보다 작고 독립적인 단위로 쪼개져서 동적으로 배포되고 관리될 수 있다.

- 리소스 격리(Isolation)
  - 애플리케이션 성능을 예측할 수 있다.

- 자원 사용량
  - 가상머신 대비 자원 효율성이 높기 때문에 하나의 물리서버에 수용될 수 있는 애플리케이션이 증가한다.



컨테이너 오케스트레이션은 다음과 같은 사용자 작업 부하를 대신하는 기능을 제공하고 있다. 

- 스케줄링 : 리소스 요구, 선호도 요구 사항 등과 같은 여러 요소를 기반으로 컨테이너를 머신에 매칭
- 애플리케이션 스케일링을 위한 복제
- 실패 처리 등



본 장에서는 가장 유명한 컨테이너 오케스트레이션 플랫폼인 쿠버네티스를 설명하도록 하겠다.



### 9.1 쿠버네티스 란 무엇인가?



쿠버네티스(Kubernetes; K8s)는 구글의 컨테이너 운영 플랫폼인 Borg와 Omega를 개발하고 관리하면서 얻은 교훈으로 설계된  오픈 소스 차세대 컨테이너 스케줄러로 구글에서 CNCF 조직으로 기증한 프로젝트이다.

쿠버네티스는 배포, 유지 관리, 애플리케이션 확장을 중심으로 느슨하게 결합 된 컴포넌트를 갖도록 설계되었다. 쿠버네티스는 노드의 기본 인프라를 추상화하고 배포 된 애플리케이션에 대해 균일한 계층(Layer)을 제공한다.



- 쿠버네티스는 컨테이너화된 워크로드와 서비스를 관리하기 위한 이식성이 좋고, 확장가능한 오픈소스 플랫폼

- 쿠버네티스는 선언적 구성과 자동화 기능을 제공하여 사용성이 용이함
- 쿠버네티스란 명칭은 조타수(helmsman)나 파일럿을 뜻하는 그리스어에서 유래
- K8s라고 표현하기도 함. "K"와 "s"와 그 사이에 있는 8글자를 나타내는 약식 표기
- 구글이 2014년에 쿠버네티스 프로젝트를 오픈소스로 제공하여 빠르게 성장하는 생태계를 가지고 있음



쿠버네티스는 주요 특징은 다음과 같다.



- 서비스 탐색과 부하 분산
  - 쿠버네티스는 DNS 이름을 사용하거나 자체 IP 주소를 사용하여 컨테이너를 노출할 수 있다. 컨테이너에 대한 트래픽이 많으면, 쿠버네티스는 네트워크 트래픽을 로드밸런싱하고 배포하여 배포가 안정적으로 이루어질 수 있다.

- 스토리지 오케스트레이션
  - 쿠버네티스를 사용하면 로컬 저장소, 공용 클라우드 공급자 등과 같이 원하는 저장소 시스템을 자동으로 탑재 할 수 있다.

- 자동화된 롤아웃과 롤백 
  - 쿠버네티스를 사용하여 배포된 컨테이너의 원하는 상태를 서술할 수 있으며 현재 상태를 원하는 상태로 설정한 속도에 따라 변경할 수 있다. 
  - 예를 들어 쿠버네티스를 자동화해서 배포용 새 컨테이너를 만들고, 기존 컨테이너를 제거하고, 모든 리소스를 새 컨테이너에 적용할 수 있다.

- 자동화된 복구(self-healing) 
  - 쿠버네티스는 실패한 컨테이너를 다시 시작하고,  '사용자 정의 상태 검사'에 응답하지 않는 컨테이너를 죽이고, 서비스 준비가 끝날 때까지 그러한 과정을 클라이언트에 보여주지 않는다.

- 시크릿과 구성 관리(Secret & Configmap)
  - 쿠버네티스를 사용하면 암호, OAuth 토큰 및 SSH 키와 같은 중요한 정보를 시크릿으로 저장하고 관리 할 수 있다. 컨테이너 이미지를 재구성하지 않고 스택 구성에 시크릿을 노출하지 않고도 시크릿 및 애플리케이션 구성을 배포 및 업데이트 할 수 있다.



### 9.2 쿠버네티스 컴포넌트



쿠버네티스를 배포하면 하나의 클러스터를 얻는다. 클러스터란 리소스 (CPU, Ram, 디스크 등)를 가용한 풀로 집계하는 호스트 집합이다.

쿠버네티스 클러스터는 컨테이너화된 애플리케이션을 실행하는 노드(Node)라고 부르는 워커 머신의 집합으로 구성된다. 모든 클러스터는 적어도 한 개의 워커 노드를 가진다.

워커 노드는 애플리케이션 워크로드의 컴포넌트인 파드(Pod)를 호스팅한다.  컨트롤 플레인은 워커 노드와 클러스터 내 파드를 관리한다. 상용 환경에서는 일반적으로 컨트롤 플레인이 여러 컴퓨터에 걸쳐 실행되고, 클러스터는 일반적으로 여러 노드를 실행하므로 내결함성과 고가용성이 제공된다.



> 워크로드(Workload)란 비즈니스 가치를 창출하는 리소스 및 코드 모음 또는 주어진 기간에 시스템에 의해 실행되어야 할 작업의 할당량을 의미한다. 쿠버네티스에서는 쿠버네티스에서 구동되는 애플리케이션이다. 워크로드가 단일 컴포넌트이거나 함께 작동하는 여러 컴포넌트이든 관계없이, 쿠버네티스에서는 워크로드를 일련의 파드 집합 내에서 실행한다. 쿠버네티스에서 파드 는 클러스터에서 실행 중인 컨테이너 집합을 나타낸다.
>
> 쿠버네티스는 다음과 같이 여러 가지 빌트인(built-in) 워크로드 자원을 제공한다.
>
> - Deployment 및 ReplicaSet : `Deployment` 는 `Deployment` 의 모든 `Pod` 가 필요 시 교체 또는 상호 교체 가능한 경우, 클러스터의 스테이트리스 애플리케이션 워크로드를 관리하기에 적합하다.
> - StatefulSet : 어떻게든 스테이트(state)를 추적하는 하나 이상의 파드를 동작하게 해준다. 예를 들면, 워크로드가 데이터를 지속적으로 기록하는 경우, 사용자는 `Pod` 와 PersistentVolume을 연계하는 `StatefulSet` 을 실행할 수 있다. 전체적인 회복력 향상을 위해서, `StatefulSet` 의 `Pods` 에서 동작 중인 코드는 동일한 `StatefulSet` 의 다른 `Pods` 로 데이터를 복제할 수 있다.
> - DaemonSet : 노드-로컬 기능(node-local facilities)을 제공하는 `Pods` 를 정의한다. 이러한 기능들은 클러스터를 운용하는 데 기본적인 것일 것이다. 예를 들면, 네트워킹 지원 도구 또는 애드온 등이 있다. `DaemonSet` 의 명세에 맞는 노드를 클러스터에 추가할 때마다, 컨트롤 플레인은 해당 신규 노드에 `DaemonSet` 을 위한 `Pod` 를 스케줄한다.
> - Job 및 CronJob : 실행 완료 후 중단되는 작업을 정의한다. `CronJobs` 이 스케줄에 따라 반복되는 반면, 잡은 단 한 번의 작업을 나타낸다.
>
> 쿠버네티스는 사용자 정의 워크로드 자원을 정의할 수 있다.



> 이전 쿠버네티스 문서에는 컨트롤 플레인(Control Plane)이라는 용어 대신 마스터 노드라는 용어를 사용하였다. 
>
> 무슨 이유인지는 모르겠지만 컨트롤 플레인이 반드시 마스터 노드에 배치될 필요는 없다는 의미로 마스터 노드라는 용어를 사용하지 않고 컨트롤 플레인으로 표현한 것으로 추측된다. 
>
> 하지만 안정적인 컨테이너 오케스트레이션 운영을 위해서는 워커 노드와 분리된 3개의 마스터 노드를 구성하고 여기에 컨트롤 플레인을 배치하는 것이 좋다.



쿠버네티스 클러스터를 구성하는 컴포넌트들은 [그림 9-1]과 같다. 



![](kubernetes/%EA%B7%B8%EB%A6%BC%209-1.png)

[그림 9-1] 쿠버네티스 컴포넌트





#### 9.2.1 컨트롤 플레인 컴포넌트



컨트롤 플레인 컴포넌트는 클러스터에 관한 전반적인 결정(예를 들어, 스케줄링)을 수행하고 클러스터 이벤트(예를 들어, deployment의 `replicas` 필드에 대한 요구 조건이 충족되지 않을 경우 새로운 파드를 구동시키는 것)를 감지하고 반응한다.

컨트롤 플레인 컴포넌트는 클러스터 내 어떠한 머신에서든지 동작할 수 있다. 그러나 간결성을 위하여, 구성 스크립트는 보통 동일 머신 상에 모든 컨트롤 플레인 컴포넌트를 구동시키고, 사용자 컨테이너는 해당 머신 상에 동작시키지 않는다. 고가용성을 위하여 여러 머신에서 실행되는 컨트롤 플레인을 설정하는 예제는 https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/를 참고하기 바란다.



- API 서버
  - API 서버는 쿠버네티스 API를 노출하는 쿠버네티스 컨트롤 플레인 컴포넌트이다. API 서버는 쿠버네티스 컨트롤 플레인의 프론트 엔드다.
  - 쿠버네티스 API 서버의 주요 구현체는 kube-apiserver다. kube-apiserver는 수평으로 확장되도록 디자인되었다. 즉, 더 많은 인스턴스를 배포해서 스케일링할 수 있다. 여러 kube-apiserver 인스턴스를 실행하고, 인스턴스간의 트래픽을 균형있게 조절할 수 있다.
- etcd
  - etcd는 모든 클러스터 데이터를 저장하기 위한 쿠버네티스 백업 저장소(Backing Store)로 사용되는 정합성 및 고가용성을 제공하는 Key-Value 저장소다.
  - 쿠버네티스 클러스터에서 etcd를 백업 저장소로 사용한다면, 이 데이터에 대한 백업 플랜을 필수적으로 구성하여야 한다.
  - etcd에 대한 자세한 정보는 공식문서인 https://etcd.io/docs/를 참고하기 바란다.

- 스케쥴러(Scheduler)
  - 스케쥴러는 아직 노드가 배정되지 않은 새로 생성된 파드를 감지하고, 실행할 노드를 선택하는 컨트롤 플레인 컴포넌트다.
  - 스케줄링 결정을 위해서 고려되는 요소는 개별 및 총체적 자원 요구 사항, 하드웨어/소프트웨어/정책 제약사항, 선호(affinity) 및 비선호(anti-affinity) 명세, 데이터 지역성, 워크로드간 간섭, 데드라인을 포함한다.

* 컨트롤러 매니저(Controller Manager)
  * 컨트롤러 매니저는 컨트롤러 프로세스를 실행하는 컨트롤 플레인 컴포넌트로 kube-controller-manager라고 부른다.
  * 논리적으로, 각 컨트롤러는 복잡성을 낮추기 위해 분리된 프로세스로 구성되어  모두 단일 바이너리로 컴파일되고 단일 프로세스 내에서 실행된다. 컨트롤러는 적어도 하나 이상의 쿠버네티스 자원 유형을 추적하고 이를 조절하는 데몬이라고 볼 수 있다.
  * 여러 유형의 컨트롤러가 존재하며, 주요 컨트롤러는 다음과 같다.
    - 노드 컨트롤러 : 노드가 다운되었을 때 통지와 대응에 관련한 책임을 갖는다.
    - 잡 컨트롤러: 일회성 작업을 나타내는 잡 객체를 감시한 다음, 해당 작업을 완료할 때까지 동작하는 파드를 생성한다.
    - 엔드포인트슬라이스(EndpointSlice) 컨트롤러: 서비스와 파드 사이의 연결고리를 제공하기 위해 엔드포인트슬라이스(EndpointSlice) 객체를 채운다(Populate).
    - 서비스어카운트(ServiceAccount) 컨트롤러: 신규 네임스페이스에 대한 기본 서비스어카운트(ServiceAccount)를 생성한다.

- 클라우드 컨트롤러 매니저(Cloud Controller Manager)
  - 클라우드별 제어 로직을 포함하는 쿠버네티스 컨트롤 플레인 컴포넌트로 cloud-controller-manager라고 부른다. 클라우드 컨트롤러 매니저를 통해 클러스터를 클라우드 제공 사업자의 API에 연결하고, 해당 클라우드 플랫폼과 상호 작용하는 컴포넌트와 클러스터 내부에서 상호 작용하는 컴포넌트를 분리할 수 있게 해 준다.
  - 클라우드 컨트롤러 매니저는 현재 클라우드 제공 사업자에 필요한 컨트롤러만 실행한다. 온프레미스나 PC로 구성된 학습 환경에서 쿠버네티스를 실행 중인 경우 클러스터에는 클라우드 컨트롤러 매니저가 없다.
  - kube-controller-manager와 마찬가지로 cloud-controller-manager는 단일 바이너리에서 단일 프로세스로 실행되는 여러 논리적으로 독립된 컨트롤 루프를 조합한다. 수평으로 확장(두 개 이상의 복제 실행)해서 성능을 향상시키거나 장애를 견딜 수 있다.
  - 다음 컨트롤러들이 클라우드 제공 사업자에 의존성을 가질 수 있다.
    - 노드 컨트롤러 : 노드가 응답을 멈춘 후 클라우드 상에서 삭제되었는지 판별하기 위해 클라우드 제공 사업자에게 확인
    - 라우트 컨트롤러 : 주어진 클라우드 인프라스트럭처에 라우트를 세팅
    - 서비스 컨트롤러 : 클라우드 제공 사업자의 로드밸런서를 생성, 업데이트, 삭제



#### 9.2.2 노드 컴포넌트



노드 컴포넌트는 모든 노드 상에서 동작하며, 동작 중인 파드를 유지 관리하고 쿠버네티스 런타임 환경을 제공한다. 



* kubelet
  * 클러스터의 각 노드에서 실행되는 에이전트. Kubelet은 파드에서 컨테이너가 확실하게 동작하도록 관리한다.
  * Kubelet은 다양한 메커니즘을 통해 제공된 파드 명세(PodSpec) 모음을 받아서 컨테이너가 해당 파드 명세에 따라 건강하게 동작하는지 확인한다. Kubelet은 쿠버네티스를 통해 생성되지 않은 컨테이너는 관리하지 않는다.

* kube-proxy
  * kube-proxy는 클러스터의 각 노드에서 실행되는 네트워크 프록시로 쿠버네티스의 서비스(Service) 개념에 대한 구현체다.
  * kube-proxy는 노드의 네트워크 규칙을 유지 관리한다. 이러한 네트워크 규칙은 내부 혹은 클러스터 외부 네트워크 세션으로부터 파드로의 네트워크 통신을 할 수 있도록 해준다.
  * kube-proxy는 운영 체제에 가용한 패킷 필터링 계층이 있고 사용가능할 경우 이를 사용한다. 그렇지 않으면, kube-proxy는 트래픽 자체를 포워드(forward)한다.

* 컨테이너 런타임
  * 컨테이너 런타임은 컨테이너 실행을 담당하는 소프트웨어이다.
  * 쿠버네티스는 containerd, CRI-O와 같은 컨테이너 런타임 및 모든 쿠버네티스 컨테이너 런타임 인터페이스(CRI, Container Runtime Interface) 구현체를 지원한다.
  * 
  * 주요 컨테이너 런타임 및 쿠버네티스 CRI는 다음을 참고하기 바란다.
    * containerd : https://containerd.io/docs/
    * CRI-O : https://cri-o.io/#what-is-cri-o
    * 쿠버네티스 CRI 규격 : https://github.com/kubernetes/community/blob/master/contributors/devel/sig-node/container-runtime-interface.md
    * 현재 쿠버네티스 CRI 규격과 호환되는 CRI 런타임
      * cri-o : https://github.com/cri-o/cri-o
      * rktlet : https://github.com/kubernetes-retired/rktlet
      * frakti : https://github.com/kubernetes/frakti
      * cri-containerd : https://github.com/containerd/cri
      * singularity-cri : https://github.com/sylabs/singularity-cri



#### 9.2.3 애드온



애드온은 클러스터 기능을 구현하기 위하여 쿠버네티스 자원(데몬셋, 디플로이먼트 등)을 이용한다. 이들은 클러스터 단위의 기능을 제공하기 때문에 애드온에 대한 네임스페이스 리소스는 `kube-system` 네임스페이스에 속한다.

주요 애드온은 다음과 같으며 자세한 애드온들은 https://kubernetes.io/docs/concepts/cluster-administration/addons/을 참고하기 바란다.



* DNS
  * 여타 애드온들이 절대적으로 요구되지 않지만, 많은 예시에서 필요로 하기 때문에 모든 쿠버네티스 클러스터는 클러스터 DNS를 갖추어야만 한다.
  * 클러스터 DNS는 현재 환경에 존재하는 다른 DNS 서버(들)과는 별도로, 쿠버네티스 서비스를 클러스터 내부의 IP와 매핑하기 위한 DNS 레코드를 제공해주는 DNS 서버다.
  * 쿠버네티스에 의해 구동되는 컨테이너들은 자동으로 DNS 검색을 위하여 이 DNS 서버를 자동으로 포함한다.

* 대시보드
  * 대시보드는 쿠버네티스 클러스터를 위한 범용의 웹 기반 UI다. 사용자가 클러스터 자체뿐만 아니라, 클러스터에서 동작하는 애플리케이션에 대한 관리와 문제 해결을 할 수 있도록 해준다.

* 컨테이너 리소스 모니터링
  * 컨테이너 리소스 모니터링은 중앙 데이터베이스 내의 컨테이너들에 대한 포괄적인 시계열 매트릭스를 기록하고 그 데이터를 열람하기 위한 UI를 제공해 준다. 쿠버네티스는 CNCF의 가시성 및 분석/모니터링 프로젝트인 오픈 메트릭(https://openmetrics.io/)에서 동작하도록 설계되었으며 프로메테우스와 거의 100% 상위 호환성을 갖는 확장 포맷이다.

* 클러스터-레벨 로깅
  * 클러스터-레벨 로깅 메커니즘은 검색/열람 인터페이스와 함께 중앙 로그 저장소에 컨테이너 로그를 저장하는 책임을 진다.



쿠버네티스 컴포넌트들은 다소 생소할 수 있지만 마이크로서비스를 관리하는데 필요한 주요 패턴들이 구현된 플랫폼이기 때문에 그 원리를 이해하는 것이 중요하다. 우리는 8장에서 도커로 구현된 많은 패턴들이 쿠버네티스로 전환되면서 제거되는 것을 살펴볼 것이다. 이를 통하여 쿠버네티스 컴포넌트를 이해할 수 있을 것이므로 너무 어렵다고 생각하지 말기 바란다.



### 9.3 쿠버네티스 설치



이제 본격적으로 쿠버네티스를 설치하도록 하겠다. 물론 클라우드 제공 사업자를 사용한다면 미리 구성된 쿠버네티스 클러스터를 사용할 수 있겠지만 9장에서는 하나의 노트북 또는 PC 로컬에서 실습할 수 있도록 가벼운 쿠버네티스를 사용할 것이다. 

로컬에서 사용할 수 있는 쿠버네티스 배포판은 아래와 같이 여러 종류가 있다.

* Minikube(https://minikube.sigs.k8s.io/docs/)
* K3S
* Rancher



#### 9.3.1 Minikube



Minikube는 쿠버네티스에서 공식으로 제공하는 배포판이다. Minikube는 다음과 같은 가이드가 제공되고 있다.

* Minikube 설치 및 사용법 : https://minikube.sigs.k8s.io/docs/start/
* 쿠버네티스 가이드 : https://kubernetes.io/docs/tutorials/hello-minikube/



Minikube는 Kubernetes를 로컬에서 쉽게 실행할 수있는 도구이다. Minikube는 Kubernetes를 사용해 보거나 매일 개발하려는 사용자를 위해 노트북의 VM 내부에 단일 노드 Kubernetes 클러스터를 실행한다.

Minikube는 다음과 같은 사양이 필요하다.

- 2 CPU 이상
- 2GB 이상의 메모리 여유공간
- 20GB 이상의 디스크 여유공간
- 인터넷 접속 온라인 상태
- Docker, QEMU, Hyperkit, Hyper-V, KVM, Parallels, Podman, VirtualBox, VMware Fusion/Workstation 등의 컨테이너 혹은 가상머신 관리자



우리는 이미 8장에서 WSL 2와 도커를 설치하였으므로 WSL 2와 도커 환경에서 Minikube를 설치하는 것으로 설명하였다. 



##### 9.3.1.1 Minikube 설치



우선  https://minikube.sigs.k8s.io/docs/start/에 접속하면 



##### 9.3.1.2 Minikube 기본 사용법



설치 후 Minikube를 시작하려면 다음 명령을 시작한다.



```shell
$ minikube start
```



​	minikube start	 명령은 minikube라는 kubectl 컨텍스트를 생성한다. 이 컨텍스트에는 minikube 클러스터와 통신하기 위한 Configuration이 포함되어 있다.



Minikube는이 컨텍스트를 자동으로 기본값으로 설정하지만, 중간에 다른 컨텍스트로 이동될 수 있으니 명확하게 아래와 같이 실행한다.



```shell
$ kubectl config use-context minikube
```



쿠버네티스 대시 보드에 액세스하려면 다음 명령을 실행한다.



```shell
$ minikube console
```



대시 보드는 기본 브라우저에서 접속된다.



![Kubernetes Dashboard (Web UI)](kubernetes/Kubernetes%20Dashboard%20(Web%20UI).PNG)



minikube stop 명령을 사용하여 클러스터를 중지 할 수 있다. 이 명령은 minikube 가상 머신을 중지시키지만 모든 클러스터 상태 및 데이터를 보존한다. 클러스터를 다시 시작하면 이전 상태로 복원된다.

minikube delete 명령을 사용하여 클러스터를 삭제할 수 있다. 이 명령은 minikube 가상 머신을 종료 및 삭제한다. 데이터나 상태는 보존되지 않는다.



#### 9.3.2 K3s



K3s 리눅스 재단의 Rancher 에서 만든 kubernetes 경량화 제품이다. K3s 공식 사이트(https://docs.k3s.io/kr/)에 따르면 K3s는 경량의 쿠버네티스를 의미하며 간편한 설치와 절반의 메모리, 모든 것을 100MB 미만의 바이너리로 제공하고 있다.

- K3s는 쉬운 배포
- 낮은 설치 공간
  - kubernetes 대비 절반의 메모리 사용
  - 100MB 미만의 바이너리 제공
- CNCF(Cloud Native Computing Foundation) 인증 Kubernetes 제품
- 일반적인 K8s 에서 작동하는 YAML을 이용할 수 있음



##### 9.3.2.1 K3s 아키텍처



고가용성 K3s 서버 클러스터의 아키텍처와 단일 노드 서버 클러스터와의 차이점 및 에이전트 노드가 K3s 서버에 등록되는 방법은 다음과 같다.

- 서버 노드는 `k3s server` 명령을 실행하는 호스트로 정의되며, 컨트롤 플레인 및 데이터스토어 구성 요소는 K3s에서 관리합니다.
- 에이전트 노드는 데이터스토어 또는 컨트롤 플레인 구성 요소 없이 `k3s agent` 명령을 실행하는 호스트로 정의됩니다.
- 서버와 에이전트 모두 kubelet, 컨테이너 런타임 및 CNI를 실행합니다. 에이전트 없는 서버 실행에 대한 자세한 내용은 [고급 옵션](https://docs.k3s.io/kr/advanced#running-agentless-servers-experimental) 설명서를 참조하세요.

[![Deploying, Securing Clusters in 8 minutes with Kubernetes](https://github.com/ssongman/ktds-edu-k8s-istio/raw/main/kubernetes/kubernetes.assets/k3s_falco_sysdig-02-k3s_arch.png)](https://github.com/ssongman/ktds-edu-k8s-istio/blob/main/kubernetes/kubernetes.assets/k3s_falco_sysdig-02-k3s_arch.png)

- k3s 에서는 containerd 라는 제품을 사용함



##### 9.3.2.2 WSL 2에서 K3s 설치



이 절에서는 WSL 2 상에서 K3s를 Stand Alone 모드로 설치한다.



- k3s install

```
## root 권한으로 수행한다.
$ su
Password:

$ curl -sfL https://get.k3s.io | sh -

# 다른 옵션 : kubeconfig 파일의 권한 조정
# 
$ curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644


[INFO]  Finding release for channel stable
[INFO]  Using v1.23.6+k3s1 as release
…
[INFO]  systemd: Starting k3s   <-- 마지막 성공 로그

# 20초 정도 소요됨
```



- [참고]root password 를 모를때 변경하는 방법

```
# windows cmd 명령수행하여 root 로 wsl 실행
$ wsl -u root 

# root password 변경 가능
$ passwd
```



- 확인

```
$ k3s kubectl version
Client Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.6+k3s1", GitCommit:"418c3fa858b69b12b9cefbcff0526f666a6236b9", GitTreeState:"clean", BuildDate:"2022-04-28T22:16:18Z", GoVersion:"go1.17.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"23", GitVersion:"v1.23.6+k3s1", GitCommit:"418c3fa858b69b12b9cefbcff0526f666a6236b9", GitTreeState:"clean", BuildDate:"2022-04-28T22:16:18Z", GoVersion:"go1.17.5", Compiler:"gc", Platform:"linux/amd64"}
```



Client 와 Server Version 이 각각 보인다면 설치가 잘 된 것이다.

설치가 안된다면 아래와 같이 수동설치를 진행해 보자.

- 수동설치

```
# root 권한으로

$ k3s server &
…
COMMIT 
…

# k3s 데몬 확인
$ ps -ef|grep k3s
root         590     405  0 13:05 pts/0    00:00:00 sudo k3s server
root         591     590 76 13:05 pts/0    00:00:26 k3s server
root         626     591  5 13:05 pts/0    00:00:01 containerd -c /var/lib/rancher/k3s/agent/etc/containerd/config.toml -a /run/k3s/containerd/containerd.sock --state /run/k3s/containerd --root /var/lib/rancher/k3s/agent/containerd
...

$ k3s kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.4+k3s1", GitCommit:"8d0255af07e95b841952563253d27b0d10bd72f0", GitTreeState:"clean", BuildDate:"2023-04-20T00:33:18Z", GoVersion:"go1.19.8", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.4+k3s1", GitCommit:"8d0255af07e95b841952563253d27b0d10bd72f0", GitTreeState:"clean", BuildDate:"2023-04-20T00:33:18Z", GoVersion:"go1.19.8", Compiler:"gc", Platform:"linux/amd64"}
```



##### 9.3.2.3 kubeconfig 설정



일반 User가 직접 kubctl 명령 실행을 위해서는 kube config 정보(~/.kube/config) 가 필요하다.

k3s 를 설치하면 /etc/rancher/k3s/k3s.yaml 에 정보가 존재하므로 이를 복사한다. 또한 모든 사용자가 읽을 수 있도록 권한을 부여 한다.

- 일반 user 로 수행
  - kubectl 명령을 수행하기를 원하는 특정 사용자로 아래 작업을 진행한다.



```
## 일반 user 권한으로 실행

$ mkdir -p ~/.kube

$ cp /etc/rancher/k3s/k3s.yaml ~/.kube/config

$ ll ~/.kube/config
-rw-r--r-- 1 song song 2957 May 14 03:44 /home/song/.kube/config

# 자신만 RW 권한 부여
$ chmod 600 ~/.kube/config

$ ls -ltr ~/.kube/config
-rw------- 1 song song 2957 May 14 03:44 /home/song/.kube/config


## 확인
$ kubectl version
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.4+k3s1", GitCommit:"8d0255af07e95b841952563253d27b0d10bd72f0", GitTreeState:"clean", BuildDate:"2023-04-20T00:33:18Z", GoVersion:"go1.19.8", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"26", GitVersion:"v1.26.4+k3s1", GitCommit:"8d0255af07e95b841952563253d27b0d10bd72f0", GitTreeState:"clean", BuildDate:"2023-04-20T00:33:18Z", GoVersion:"go1.19.8", Compiler:"gc", Platform:"linux/amd64"}
```



이제 root 권한자가 아닌 다른 사용자도 kubectl 명령을 사용할 수 있다.



#### 9.3.3 K3d



K3d는 Rancher/SUSE K3s 쿠버네티스 배포를 둘러싼 오픈 소스 래퍼로 도커내에서 컨트롤 플레인을 실행할 목적으로 사용할수 있다. 전체 스택은 도커에서 실행되므로 가볍고 설정하기 쉬운 완전히 컨테이너화된 클러스터를 제공한다.

K3s는 광범위한 워크플로를 위해 설계되었지만 K3d는 이미 도거를 사용하고 있는 개발 상황에 더 구체적으로 중점을 두고 있다. 가상 머신이나 다른 시스템 서비스를 실행하지 않고도 기존 도커 호스트에서 쿠버네티스 클러스터를 가동할 수 있다.



https://k3d.io/v5.5.2/



K3d는 리눅스, 맥(Homebrew 포함) 및 윈도우즈(Chocolatey를 통해)를 지원한다. 에서 작동합니다. k3d 다른 플랫폼에 대한 CLI 설치 지침은 https://k3d.io/v5.5.2/



##### 9.3.3.1 K3d CLI 설치



`k3d` CLI는 k3s를 더 손쉽게 설치할 수 있게 도와주는 도구로 클러스터를 만들고 관리하기 위한 관리 명령을 제공한다. GitHub에서 최신 CLI를 찾거나 설치 스크립트를 실행하여 시스템에 대한 올바른 다운로드를 자동으로 얻을 수 있다.



```sh
$ curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
Preparing to install k3d into /usr/local/bin
[sudo] password for yuskim:
k3d installed into /usr/local/bin/k3d
Run 'k3d --help' to see what you can do with it.
```



스크립트는 `k3d` 바이너리를 `/usr/local/bin` 디렉토리에 복사한다. `k3d version` 명령을 실행하여 설치 성공 여부를 확인한다.



```sh
$ k3d version
k3d version v5.5.2
k3s version v1.27.4-k3s1 (default)
```



##### 9.3.3.2 클러스터 생성



K3d CLI는 새 K3s 클러스터를 자동으로 생성하고 시작하는 `cluster create` 명령을 제공한다.



```sh
$ k3d cluster create --servers 1 --agents 1 --port "8888:80@loadbalancer" --port "8889:443@loadbalancer"
INFO[0000] portmapping '8888:80' targets the loadbalancer: defaulting to [servers:*:proxy agents:*:proxy]
INFO[0000] portmapping '8889:443' targets the loadbalancer: defaulting to [servers:*:proxy agents:*:proxy]
INFO[0000] Prep: Network
INFO[0000] Created network 'k3d-k3s-default'
INFO[0000] Created image volume k3d-k3s-default-images
INFO[0000] Starting new tools node...
INFO[0000] Starting Node 'k3d-k3s-default-tools'
INFO[0001] Creating node 'k3d-k3s-default-server-0'
INFO[0001] Creating node 'k3d-k3s-default-agent-0'
INFO[0001] Creating LoadBalancer 'k3d-k3s-default-serverlb'
INFO[0002] Using the k3d-tools node to gather environment information
INFO[0002] Starting new tools node...
INFO[0003] Starting Node 'k3d-k3s-default-tools'
INFO[0004] Starting cluster 'k3s-default'
INFO[0004] Starting servers...
INFO[0005] Starting Node 'k3d-k3s-default-server-0'
INFO[0010] Starting agents...
INFO[0010] Starting Node 'k3d-k3s-default-agent-0'
INFO[0016] Starting helpers...
INFO[0016] Starting Node 'k3d-k3s-default-serverlb'
INFO[0024] Injecting records for hostAliases (incl. host.k3d.internal) and for 4 network members into CoreDNS configmap...
INFO[0027] Cluster 'k3s-default' created successfully!
INFO[0027] You can now use it like this:
kubectl cluster-info
```



아규먼트 없이 명령을 실행하면 클러스터 이름이 `k3s-default`로 지정된다. 만약 클러스터 이름을 명명하고 싶으면 다음과 같은 명령을 사용한다.



```sh
$ k3d cluster create my-cluster
...
```



K3d는 새 클러스터에 대한 연결을 포함하도록 Kubernetes 구성 파일(`.kube/config`)을 자동으로 수정한다. 우선 기본값으로 연결되어 있으니 `kubectl` 명령이 이제 K3d 환경을 대상으로 한다.



```sh
$ kubectl cluster-info
Kubernetes control plane is running at https://0.0.0.0:44417
CoreDNS is running at https://0.0.0.0:44417/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://0.0.0.0:44417/api/v1/namespaces/kube-system/services/https:metrics-server:https/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```



클러스터 노드를 확인하기 위하여 `kubectl get node`를 실행해 보면 다음과 같은 노드가 생성되어 있음을 알 수 있다.



```
$ kubectl get nodes
NAME                       STATUS   ROLES                  AGE     VERSION
k3d-k3s-default-server-0   Ready    control-plane,master   7m36s   v1.27.4+k3s1
```



`docker ps`를 실행하면 세 개의 컨테이너가 표시된다. 하나는 K3s이고 다른 하나는 트래픽을 클러스터로 전달하는 K3d의 프록시용입니다.



```
$ docker ps
CONTAINER ID   IMAGE                            COMMAND                  CREATED         STATUS         PORTS                             NAMES
48cd0608c9fb   ghcr.io/k3d-io/k3d-tools:5.5.2   "/app/k3d-tools noop"    3 minutes ago   Up 3 minutes                                     k3d-k3s-default-tools
ee5f7593e18e   ghcr.io/k3d-io/k3d-proxy:5.5.2   "/bin/sh -c nginx-pr…"   3 minutes ago   Up 3 minutes   80/tcp, 0.0.0.0:44417->6443/tcp   k3d-k3s-default-serverlb
6251ed2c64cc   rancher/k3s:v1.27.4-k3s1         "/bin/k3s server --t…"   4 minutes ago   Up 3 minutes                                     k3d-k3s-default-server-0
```

* k3d-tools : K3d의 기능을 제공하는 컨테이너 이미지 
* k3d-proxy : 트래픽을 k3s-default 클러스터로 전달하기 위한 K3d의 프록시
* rancher/k3s : k3s 클러스터



##### 9.3.3.3 클러스터 사용



일반적으로, 잘 사용하지는 않는 단어이긴 하지만 네트워크 트래픽은 인그레스(Ingress)와 이그레스(Egress)로 구분된다. 인그레스는 외부로부터 서버 내부로 유입되는 네트워크 트래픽을, 이그레스는 서버 내부에서 외부로 나가는 트래픽을 의미한다. 

쿠버네티스에도 인그레스라고 하는 리소스 객체가 존재한다. 쿠버네티스의 인그레스는 외부에서 쿠버네티스 클러스터 내부로 들어오는 네트워크 요청 : 즉, 인그레스 트래픽을 어떻게 처리할지 정의한다. 쉽게 말하자면, 인그레스는 외부에서 쿠버네티스에서 실행 중인 Deployment와 Service에 접근하기 위한, 일종의 게이트웨이(Gateway) 역할을 담당한다. 인그레스를 사용하지 않을 경우, 외부 요청을 처리할 수 있는 방법은 노드포트( NodePort), 외부아이피(ExternalIP) 등이 있다. 그러나 이러한 방법들은 세밀한 조정에는 한계가 있다.  

클러스터와 상호작용하고 Pod를 배포하기 위하여  인그레스 게이트웨이(Ingress Gateway)를 설정해보자.

우선 인그레스 게이트웨이로 NGINX를 설치하고 80 포트로 노드포트를 연결한다.

```sh
$ kubectl run nginx --image nginx:latest
pod/nginx created

$ kubectl expose pod/nginx --port 80 --type NodePort
service/nginx exposed
```



NGINX 서버에 액세스하려면 먼저 쿠버네티스 노드에 할당된 IP 주소를 찾는다.



```sh
$ kubectl get nodes -o wide
NAME                       STATUS   ROLES                  AGE     VERSION        INTERNAL-IP   EXTERNAL-IP   OS-IMAGE   KERNEL-VERSION                      CONTAINER-RUNTIME
k3d-k3s-default-server-0   Ready    control-plane,master   7h42m   v1.27.4+k3s1   172.21.0.3    <none>        K3s dev    5.15.90.1-microsoft-standard-WSL2   containerd://1.7.1-k3s1
```



이제 k3s-default 클러스터에 접속할 IP는 IP는 172.21.0.3이다.

다음으로 nginx 서비스에 할당된 노드포트를 확인해보자.



```sh
$ kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP   10.43.0.1      <none>        443/TCP        8h
nginx        NodePort    10.43.52.223   <none>        80:32508/TCP   32m
```



노출된 포트 번호는 32508이다. http://172.21.0.3:32508 에 접속하면 기본 NGINX 시작 페이지가 표시된다.



```sh
$ curl http://172.21.0.3:32508
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```



서비스 노출 및 인그레스 네트워킹 설정에 대한 추가 설명은 K3d 가이드를 확인하기 바란다.



##### 9.3.3.4 K3s 플래그 활성화



`cluster create` 명령은 표준 K3s 클러스터 생성 프로세스를 래핑합니다. `--k3s-arg` 플래그를 이용하여 아규먼트를 K3s에 전달할 수 있다. 플래그 값은 K3d가 K3s 바이너리를 호출할 때 포함될 아규먼트여야 한다.



```sh
$ k3s cluster create --k3s-arg "--disable=traefik"
```



이 예는 K3s에 내장된 Traefik 구성 요소를 비활성화하도록 한다.



##### 9.3.3.5 호스트에서 실행되는 서비스에 액세스



K3d에서 실행하는 일부 워크로드는 도커 호스트에서 이미 실행 중인 서비스에 액세스해야 할 수 있다. K3d는 기본 DNS 구성 내에서 `host.k3d.internal`라는 호스트 이름을 제공한다. 이것은 자동으로 호스트 시스템으로 인식한다. 파드 내에서 이 특수 호스트 이름을 참조하여 쿠버네티스 외부에서 실행되는 기존 데이터베이스, 파일 공유 및 기타 API에 액세스할 수 있다.



##### 9.3.3.6 로컬 도커 이미지 사용

K3d/K3s 클러스터는 로컬 도커 이미지에 액세스할 수 없다. 클러스터와 모든 구성 요소가 도커  내부에서 실행 중이기 때문이다. 호스트에만 있는 프라이빗 이미지를 사용하려고 하면 에러가 발생한다.

이를 해결하는 두 가지 방법이 있다. 이미지를 레지스트리에 푸시하거나 K3d의 이미지 가져오기 기능을 사용하여 로컬 이미지를 클러스터에 복사한다. 첫 번째 방법은 이미지 저장소를 중앙 집중화하고 모든 환경에서 이미지에 액세스할 수 있으므로 일반적으로 선호된다. 로컬 변경 사항을 빠르게 테스트할 때 방금 빌드한 이미지를 직접 가져올 수 있습니다.



```sh
$ k3d image import demo-image:latest
```



이 명령은 클러스터 내에서 `demo-image:latest`를 사용할 수 있도록 합니다.



K3d는 또한 이미지 레지스트리를 생성하고 노출할 수 있다. 레지스트리는 K3d가 클러스터의 액세스를 자동으로 구성할 수 있으므로 클러스터와 함께 자주 생성한다.



```sh
$ k3d cluster create --registry-create demo-registry
```



이렇게 하면 demo-registry라는 레지스트리로 새 클러스터가 시작됩니다. 레지스트리는 자체 도커 컨테이너에서 실행된다. `docker ps -f name=-registry`를 실행하여 레지스트리가 노출된 포트 번호를 찾을 수 있다. 여기서 ``는 클러스터의 이름입니다. 이미지를 이 레지스트리로 푸시하면 클러스터의 파드에서 이미지에 액세스할 수 있다.



```sh
$ docker tag demo-image:latest k3d-demo-registry.localhost:12345/demo-image:latest
$ docker push k3d-demo-registry.localhost:12345/demo-image:latest
```



필요에 따라 레지스트리를 생성할 수도 있지만 연결 세부 정보를 제공하려면 클러스터를 수동으로 재구성해야 한다.



##### 9.3.3.7 클러스터 중지



K3d 클러스터는 사용자가 직접 중지할 때까지 계속 실행된다. `cluster stop` 명령은 클러스터 데이터를 보존하면서 도커 컨테이너에서의 실행을 중지한다.



```sh
$ k3d cluster stop k3s-default
```



나중에 `cluster start` 명령을 사용하여 클러스터를 다시 시작할 수 있다.



```sh
$ k3d cluster start k3s-default
```



##### 9.3.3.8 클러스터 삭제



`cluster delete` 명령을 이용하여 클러스터를 삭제할 수 있다. 클러스터를 삭제하면 모든 저장된 내용은 삭제되고 이를 제공한 도커 컨테이너 및 볼륨이 삭제된다. 모든 클러스터를 삭제하면 호스트가 K3d CLI만 설치된 깨끗한 상태로 돌아갑니다.



```sh
$ $ k3d cluster delete k3s-default
INFO[0000] Deleting cluster 'k3s-default'
INFO[0006] Deleting cluster network 'k3d-k3s-default'
INFO[0006] Deleting 1 attached volumes...
INFO[0006] Removing cluster details from default kubeconfig...
INFO[0006] Removing standalone kubeconfig file (if there is one)...
INFO[0006] Successfully deleted cluster k3s-default!
```



클러스터가 삭제되면 Kubeconfig에서 설정한 클러스터에 대한 참조도 자동으로 제거된다.



##### 9.3.3.9 요약



K3d를 사용하면 컨테이너화된 쿠버네티스 클러스터를 실행할 수 있다. Docker를 사용할 수 있는 모든 곳에서 완전한 K3s 환경을 제공한다. K3d는 여러 노드를 지원하고 이미지 레지스트리에 대한 통합 지원을 제공하며 여러 컨트롤 플레인이 있는 고가용성 클러스터를 만드는 데 사용할 수 있다.

이미 도커를 실행 중인 개발자는 K3d를 사용하여 쿠버네티스를 작업 환경에 빠르게 추가할 수 있다. K3d는 가볍고 관리하기 쉬우며 컴퓨터에 불필요한 다른 시스템 서비스를 추가하지 않는다. 따라서 로컬 사용에 적합하지만 도커가 반드시 필요하기 때문에 도커를 사용하지 않고자 하는 상용 시스템에는 적합하지 않을 수 있다. Minikube, Microk8s 및 일반 K3와 같은 다른 쿠버네티스 배포판은 모두 실행 가능한 대안입니다.



### 9.4 쿠버네티스 사용법



이제 쿠버네티스 환경이 준비되었으므로 하나씩 개념을 익히면서 쿠버네티스의 사용법을 학습해 나가자. 



#### 9.4.1 쿠버네티스 API



쿠버네티스 컨트롤 플레인의 핵심은 API 서버이다. API 서버는 최종 사용자, 클러스터의 다른 부분 그리고 외부 컴포넌트가 서로 통신할 수 있도록 HTTP API를 제공한다.

쿠버네티스 API를 사용하면 파드(Pod), 네임스페이스(Namespace), 컨피그맵(ConfigMap) 그리고 이벤트(Event)와 같은 쿠버네티스의 API 객체를 질의(query)하고 조작할 수 있다.

대부분의 작업은 kubectl]() 커맨드 라인 인터페이스 또는 API를 사용하는 kubeadm과 같은 다른 커맨드 라인 도구를 통해 수행할 수 있다. 그러나, REST 호출을 사용하여 API에 직접 접근할 수도 있다.

쿠버네티스 API를 사용하여 애플리케이션을 개발하는 경우 클라이언트 라이브러리중 하나를 사용하는 것이 좋다.



* kubectl 
  * kubectl은 쿠버네티스 클러스터에 대해 명령을 실행하기 위한 명령 줄 인터페이스이다.
  * 자세한 내용은 https://kubernetes.io/ko/docs/reference/kubectl/를 참고하기 바란다.
* kubeadm
  * Kubeadm은 쿠버네티스 클러스터 생성을 위하여 만들어진 도구로  `kubeadm init` 및 `kubeadm join` 과 같은 클러스터를 관리하는 주요 명령을 제공한다.
  * 자세한 내용은 https://kubernetes.io/ko/docs/reference/setup-tools/kubeadm/를 참고하기 바란다.
* 클라이언트 라이브러리
  * 다양한 프로그래밍 언어에서 쿠버네티스 API를 사용하기 위하여 만들어졌다. 쿠버네티스 공식 사이트에서 C, .NET, Go, Haskell, 자바, 자바스크립트, Perl, Python, Ruby 언어를 위한 클라이언트 라이브러리를 제공하고 있다.
  * 자세한 내용은 https://kubernetes.io/ko/docs/reference/using-api/client-libraries/를 참고하기 바란다.



#### 9.4.2 쿠버네티스 객체



쿠버네티스에서 컨테이너들은 쿠버네티스 API에 의하여 제어되고 그 내용은 YAML 파일로 관리된다. 

쿠버네티스 객체는 쿠버네티스 시스템에서 영속성을 가지는 객체이다. 쿠버네티스는 클러스터의 상태를 나타내기 위해 이 객체를 이용한다. 예를 들어 다음과 같이 기술할 수 있다.



- 어떤 컨테이너화된 애플리케이션이 동작 중인지 (그리고 어느 노드에서 동작 중인지)
- 그 애플리케이션이 이용할 수 있는 자원
- 그 애플리케이션이 어떻게 재시작 정책, 업그레이드, 그리고 내결함성 등에 동작해야 하는지에 대한 정책



쿠버네티스 객체는 하나의 "의도를 담은 레코드"이다. 객체를 생성하게 되면, 쿠버네티스 시스템은 그 객체 생성을 보장하기 위해 지속적으로 작동할 것이다. 객체를 생성함으로써, 클러스터의 워크로드를 어떤 형태로 보이고자 하는지에 대해 효과적으로 쿠버네티스 시스템에 전한다. 

생성이든, 수정이든, 또는 삭제든 쿠버네티스 객체를 동작시키려면, 쿠버네티스 API를 이용해야 한다. 예를 들어, `kubectl` 커맨드-라인 인터페이스를 이용할 때, CLI는 필요한 쿠버네티스 API를 호출해 준다. 또한, 클라이언트 라이브러리 중 하나를 이용하여 애플리케이션에서 쿠버네티스 API를 직접 이용할 수도 있다.



##### 9.4.2.1 객체 명세(Spec)와 상태(Status)



거의 모든 쿠버네티스 객체는 객체의 구성을 결정해주는 객체  명세와 객체 상태로 구성된 객체 필드를 포함하고 있다. 명세를 가진 객체는 객체를 생성할 때 리소스에 원하는 특징(Characteristics)에 대한 설명을 제공해서 설정한다.

상태는 쿠버네티스 시스템과 컴포넌트에 의해 제공되고 업데이트된 객체의 *현재 상태* 를 기술하고 있다. 쿠버네티스 컨트롤 플레인은 모든 객체의 실제 상태를 사용자가 의도한 상태와 일치시키기 위해 끊임없이 그리고 능동적으로 관리한다.

예를 들어, 쿠버네티스에서 디플로이먼트(Deployment)는 클러스터에서 동작하는 애플리케이션을 표현하는 객체이다. 디플로이먼트를 생성할 때, 디플로이먼트 명세에 3개의 애플리케이션 레플리카가 동작되도록 설정할 수 있다. 쿠버네티스 시스템은 그 디플로이먼트 명세를 읽어 명세에 일치되도록 상태를 업데이트하여 3개의 의도한 애플리케이션 인스턴스를 구동시킨다. 만약, 그 인스턴스들 중 어느 하나가 어떤 문제로 인해 멈춘다면(상태 변화 발생), 쿠버네티스 시스템은 보정(Correction) - 이 경우에는 대체 인스턴스를 시작하여 - 을 통해 명세와 상태간의 차이에 대응한다.



##### 9.4.2.2 쿠버네티스 객체를 기술하기(Describe)



쿠버네티스에서 객체를 생성할 때, 객체의 이름과 같은 객체에 대한 기본적인 정보와 더불어, 의도한 상태를 기술한 객체 명세를 제시해 줘야만 한다. 객체를 생성하기 위해 (직접이든 또는 `kubectl`을 통해서든) 쿠버네티스 API를 이용할 때, API 요청은 요청 내용 안에 JSON 형식으로 정보를 포함시켜 줘야만 한다. **대부분의 경우 정보를 .yaml 파일로 `kubectl`에 제공한다.** `kubectl`은 API 요청이 이루어질 때, JSON 형식으로 정보를 변환시켜 준다.

여기 쿠버네티스 디플로이먼트를 위한 필수 필드와 객체 명세를 위한 YAML 파일은 다음과 같다.



```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```



위와 같은 YAML 파일을 이용하여 디플로이먼트를 생성하기 위해 다음과 같이 `kubectl apply` 명령을 사용할 수 있다.



```sh
$ kubectl apply -f https://k8s.io/examples/application/deployment.yaml
deployment.apps/nginx-deployment created
```



YAML 파일에는 다음과 같은 필드들이 필요하다.

- `apiVersion` - 이 객체를 생성하기 위해 사용하고 있는 쿠버네티스 API 버전
- `kind` - 생성하고자 하는 객체의 종류
- `metadata` - `name`, `UID`, 그리고 선택적으로 `namespace`를 포함한 객체를 유일하게 구분지어 줄 데이터
- `spec` - 객체에 대해 의도하는 상태



객체 `spec`에 대한 정확한 포맷은 모든 쿠버네티스 객체마다 다르고, 그 객체 특유의 필드 모음를 포함한다. 쿠버네티스 API 레퍼런스(https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.28/)에서 쿠버네티스를 이용하여 생성할 수 있는 객체에 대한 모든 명세들의 포맷을 살펴볼 수 있다.

예를 들어, 파드 API 레퍼런스의 spec 필드인 https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#PodSpec를 살펴보면. 파드 각 컨테이너에 대한 컨테이너 이미지와 같이 각 파드에 대해, `.spec` 필드에 포함되어 있는 파드 및 파드의 원하는 상태(desired state)가 기술되어 있다. 객체 상세에 대한 또 다른 예제로 스테이트풀셋 API의 spec 필드인 https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/stateful-set-v1/#StatefulSetSpec를 살펴보자. 스테이트풀셋의 경우, `.spec` 필드는 스테이트풀셋 및 스테이트풀셋의 원하는 상태(desired state)를 기술한다. 스테이트풀셋의 `.spec`에는 파드 객체에 대한 템플릿에 대한 설명인 https://kubernetes.io/docs/concepts/workloads/pods/#pod-templates이 존재한다. 이 템플릿은 스테이트풀셋 명세를 만족시키기 위해 스테이트풀셋 컨트롤러가 생성할 파드에 대한 상세 사항을 설명한다. 서로 다른 종류의 객체는 서로 다른 `.status`를 가질 수 있으며, 각 API 레퍼런스 페이지는 각 객체 타입에 대해 해당 `.status` 필드의 상세한 구조와 내용에 대해 설명하고 있으미 각 객체에 대한 명세와 필요 시 그 템플릿에 대해 살펴 보기 바란다.



##### 9.4.2.3 네임 스페이스



하나의 Kubernetes 클러스터를 여러 사용자, 팀 또는 원하지 상호작용에 대한 걱정없이 여러 애플리케이션을 가진  단일 사용자 등에서 사용할 수 있도록 하는 논리적 파티셔닝 기능을 뜻한다.

각 사용자, 사용자 팀 또는 애플리케이션은 다른 모든 사용자로부터 격리되어 클러스터의 클러스터의 유일한 사용자 인 것처럼 동작하는 네임 스페이스 내에 존재할 수 있다.
모든 네임 스페이스 목록은 조회하는 방법은 다음과 같다.



```shell
kubectl get namespace 또는 kubectl get ns
```



9.4.2.4 레이블(Label)과 셀렉터(Selector), 애노테이션(Annotation)



레이블은 관련된 개체 집합을 식별하고 선택하는 데 사용되는 키와 값 쌍이다. 레이블은 객체 특성을 식별하는데 사용되어 사용자에게는 중요하지만 쿠버네티스 코어 시스템에 직접적인영향은 없다. 

셀렉터는 레이블을 사용하여 개체를 필터링하거나 선택한다. 등식(=, ==,! =) 또는 단순 키-값 매칭 셀렉터 두 가지 모두 지원된다

애노테이션은 비 식별 정보 또는 메타 데이터를 포함하는 키-값 쌍이다. 애노테이션에는 레이블과 같은 문법 제한을 갖고 있지 않으며, 구조화되거나 구조화되지 않은 데이터를 포함 할 수 있다.

레이블과 셀렉터, 애노테이션의 사용 예제는 다음과 같다. 



```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  annotations:
    description: "nginx frontend"
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
```



#### 9.4.3 쿠버네티스 워크로드



워크로드는 쿠버네티스에서 구동되는 애플리케이션이다. 워크로드가 단일 컴포넌트이거나 함께 작동하는 여러 컴포넌트이든 관계없이, 쿠버네티스에서는 워크로드를 일련의 파드 집합 내에서 실행한다. 쿠버네티스에서 파드 는 클러스터에서 실행 중인 컨테이너 집합을 나타낸다.



##### 9.4.3.1 파드(Pod)



파드는 쿠버네티스의 기본 작업 단위이다. IP 주소 및 스토리지와 같은 리소스를 공유하는 컨테이너 모음을 나타낸다.

파드를 명세하는 예제는 다음과 같다.

###### 

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox
    command: ['sh', '-c', 'echo Hello Kubernetes! && sleep 3600']
```



모든 파드 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get pod 또는 kubectl get po
```



##### 9.4.3.2 디플로이먼트(Deployment)



디플로이먼트에는 파드 템플릿과 복제본 수 필드가 포함된다. 쿠버네티스는 실제 상태(파드 템플릿과 복제본 수 등)가 항상 원하는 상태와 일치하는지 확인한다. 디플로이먼트를 업데이트하면 "롤링 업데이트"를 수행한다.

디플로이먼트의 예제는 다음과 같다.



```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
```



모든 디플로이먼트 목록을 조회하는 방법은 다음과 같다.



```shell
$ kubectl get deployment
```



##### 9.4.3.3 복제 컨트롤러(ReplicationController)



수평으로 확장할 파드를 정의하기위한 프레임 워크이다. 복제 컨트롤러는 복제 할 파드 정의를 포함하고 여기에서 생성 된 파드를 다른 노드로 스케쥴링할 수 있다.

복제 컨트롤러의 예제는 다음과 같다. 



```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
```



모든 복제 컨트롤러 목록을 조회하는 방법은 다음과 같다.



```sh
$ kubectl get replicationcontroller 또는 kubectl get rc
```



##### 9.4.3.4 복제 세트(ReplicaSet)



복제 세트는 세트 기반 셀렉터를 지원하는 업그레이드 된 버전의 복제 컨트롤러다.

복제 세트의 예제는 다음과 같다.



```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      tier: frontend
    matchExpressions:
      - {key: tier, operator: In, values: [frontend]}
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: gcr.io/google_samples/gb-frontend:v3
        env:
        - name: GET_HOSTS_FROM
          value: dns
        ports:
        - containerPort: 80
```



모든 복제 세트 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get replicaset 또는 kubectl get rs
```



##### 9.4.3.5 스테이트풀 세트(StatefulSet)



상태를 유지하거나 유지해야하는 파드를 관리하는 것을 목표로하는 컨트롤러이다. 호스트 이름, 네트워크 및 스토리지를 포함한 파드들의 순서(Ordering)와 고유성(Uniqueness)을 보장한다.

스테이트풀 세트의 예제는 다음과 같다.



```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web
spec:
  selector:
    matchLabels:
      app: nginx
  serviceName: "nginx"
  replicas: 3
  template:
    metadata:
      labels:
        app: nginx
      spec:
        terminationGracePeriodSeconds: 10
        containers:
        - name: nginx
          image: k8s.gcr.io/nginx-slim:0.8
          ports:
          - containerPort: 80
            name: web
          volumeMounts:
          - name: www
            mountPath: /usr/share/nginx/html
    volumeClaimTemplates:
    - metadata:
        name: www
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: "my-storage-class"
        resources:
          requests:
            storage: 1Gi
```



모든 스테이트풀 세트 목록을 조회하는 방법은 다음과 같다.



```shell
$ kubectl get statefulset
```



##### 9.4.3.6 데몬 세트(DaemonSet)



특정 Pod의 인스턴스가 클러스터의 모든 (또는 선택한) 노드에서 실행되고 있는지 확인한다.

데몬 세트를 사용하는 예제는 다음과 같다.



```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd-elasticsearch
  namespace: kube-system
  labels:
    k8s-app: fluentd-logging
spec:
  selector:
    matchLabels:
      name: fluentd-elasticsearch
  template:
    metadata:
      labels:
        name: fluentd-elasticsearch
    spec:
      tolerations:
      - key: node-role.kubernetes.io/master
        effect: NoSchedule
      containers:
      - name: fluentd-elasticsearch
        image: gcr.io/google-containers/fluentd-elasticsearch:1.20
      terminationGracePeriodSeconds: 30
```



모든 데몬 세트 목록을 조회하는 방법은 다음과 같다.



```shell
$ kubectl get daemonset 또는 kubectl get ds
```



##### 9.4.3.7 작업(Job)



작업에서 하나 이상의 파드를 생성하고 지정된 수의 파드가 성공적으로 종료될 때까지 계속해서 파드의 실행을 재시도한다. 파드가 성공적으로 완료되면, 성공적으로 완료된 작업을 추적한다. 지정된 수의 성공 완료에 도달하면, 작업이 완료된다. 작업을 삭제하면 작업이 생성한 파드가 정리된다. 작업을 일시 중지하면 작업이 다시 재개될 때까지 활성 파드가 삭제된다.

모든 작업 목록을 조회하는 방법은 다음과 같다. 



```shell
$ kubectl get job
```



작업 상태를 확인하는 방법은 다음과 같다.



```sh
$ kubectl describe job <작업명> 또는 kubectl describe job <작업명> -o yaml 
```



##### 9.4.3.8 크론 작업(CronJob)



작업의 확장으로, cron과 유사하게 반복 일정에 따라 작업을 실행하는 방법을 제공한다.

모든 크론 작업 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get cronjob
```



#### 9.4.4 서비스와 부하분산, 네트워킹



클러스터의 모든 파드는 고유한 IP 주소를 갖는다. 이는 즉 파드간 연결을 명시적으로 만들 필요가 없으며 또한 컨테이너 포트를 호스트 포트에 매핑할 필요가 거의 없음을 의미한다. 이로 인해 포트 할당, 네이밍, 서비스 탐색, 부하분산, 애플리케이션 구성, 마이그레이션 관점에서 파드를 VM 또는 물리 호스트처럼 다룰 수 있는 깔끔하고 하위 호환성을 갖는 모델이 제시된다.

쿠버네티스는 모든 네트워킹 구현에 대해 다음과 같은 근본적인 요구사항을 만족할 것을 요구한다. (이를 통해, 의도적인 네트워크 분할 정책을 방지)

- 파드는 NAT 없이 노드 상의 모든 파드와 통신할 수 있다.
- 노드 상의 에이전트(예: 시스템 데몬, kubelet)는 해당 노드의 모든 파드와 통신할 수 있다.

이 모델은 전반적으로 덜 복잡할 뿐만 아니라, 무엇보다도 VM에 있던 애플리케이션을 컨테이너로 손쉽게 포팅하려는 쿠버네티스 요구사항을 만족시킬 수 있다. 작업을 기존에는 VM에서 실행했었다면, VM은 IP주소를 가지며 프로젝트 내의 다른 VM과 통신할 수 있었을 것이다.

쿠버네티스 IP 주소는 파드 범위에서 존재하며, 파드 내의 컨테이너들은 IP 주소, MAC 주소를 포함하는 네트워크 네임스페이스를 공유한다. 이는 곧 파드 내의 컨테이너들이 각자의 포트에 `localhost`로 접근할 수 있음을 의미한다. 또한 파드 내의 컨테이너들이 포트 사용에 있어 서로 협조해야 하는데, 이는 VM 내 프로세스 간에도 마찬가지이다. 이러한 모델은 "파드 별 IP" 모델로 불린다.

이것이 어떻게 구현되는지는 사용하는 컨테이너 런타임의 상세사항이다.

노드 자체의 포트를 파드로 포워드하도록 요청하는 것도 가능하지만(호스트 포트라고 불림), 이는 매우 비주류적인(niche) 동작이다. 포워딩이 어떻게 구현되는지도 컨테이너 런타임의 상세사항이다. 파드 자체는 호스트 포트 존재 유무를 인지할 수 없다.

쿠버네티스 네트워킹은 다음의 네 가지 문제를 해결한다.

- 파드 내의 컨테이너간 네트워킹은 루프백(loopback)을 통하여 통신한다.
- 클러스터 네트워킹은 서로 다른 파드 간의 통신을 제공한다.
- 서비스 API를 사용하면 파드에서 실행 중인 애플리케이션을 클러스터 외부에서 접근할 수 있다.
  - 인그레스는 특히 HTTP 애플리케이션, 웹사이트 그리고 API를 노출하기 위한 추가 기능을 제공한다.
- 서비스를 사용하여 서비스를 클러스터 내부에서만 사용할 수 있도록 게시할 수 있다.



##### 9.4.4.1 서비스(Sevice)



서비스는 파드 집합에서 실행 중인 애플리케이션을 네트워크 서비스로 노출하는 추상화 방법이다. 파드 그룹에 대한 액세스를 제공하는 단일 IP / 포트 조합을 정의한다. 쿠버네티스는 파드에게 고유한 IP 주소와 파드 집합에 대한 단일 DNS 명을 부여하고, 그것들 간에 로드-밸런스를 수행할 수 있다. 파드 및 포트 그룹을 클러스터 고유 가상 IP에 매핑하기 위하여 아래 예제의 my-ngnix처럼 레이블 셀렉터를 사용한다.



```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-nginx
  labels:
    run: my-nginx
spec:
  ports:
  - port: 80
    protocol: TCP
  selector:
    run: my-nginx
```



모든 서비스 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get service 또는 kubectl get svc
```



##### 9.4.4.2 인그레스(Ingress)



인그레스는 클러스터 외부에서 클러스터 내부 서비스로 HTTP와 HTTPS 경로를 노출한다. 트래픽 라우팅은 인그레스 리소스에 정의된 규칙에 의해 컨트롤된다.

[그림 9-3]은 인그레스가 모든 트래픽을 하나의 서비스로 보내는 간단한 예시이다.



![image-20230820153204684](kubernetes/%EA%B7%B8%EB%A6%BC%209-3.png)

[그림 9-3] 인그레스를 통한 외부 트래픽의 클러스터 전달



인그레스는 외부에서 서비스로 접속이 가능한 URL, 로드 밸런스 트래픽, SSL / TLS 종료 그리고 이름-기반의 가상 호스팅을 제공하도록 구성할 수 있다. 인그레스 컨트롤러는 일반적으로 로드 밸런서를 사용해서 인그레스를 수행할 책임이 있으며, 트래픽을 처리하는데 도움이 되도록 에지 라우터 또는 추가 프런트 엔드를 구성할 수도 있다.

인그레스는 임의의 포트 또는 프로토콜을 노출시키지 않는다. HTTP와 HTTPS 이외의 서비스를 인터넷에 노출하려면 보통 Service.Type=NodePort 또는 Service.Type=LoadBalancer 유형의 서비스를 사용한다.

인그레스 컨트롤러는 클러스터 서비스 (일반적으로 http)를 외부 세계에 노출하는 기본 방법이다. 인그레스 컨트롤러가 있어야 인그레스를 충족할 수 있다. 인그레스 리소스만 생성한다면 효과가 없다. 자세한 내용은 https://kubernetes.io/ko/docs/concepts/services-networking/ingress-controllers를 참고하기 바란다.



다음은 최소한의 구성으로 인그레스 자원을 구성한 예제이다.



```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: minimal-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx-example
  rules:
  - http:
      paths:
      - path: /testpath
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 80
```



모든 인그레스 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get ingress
```



#### 9.4.5 스토리지



쿠버네티스는 애플리케이션의 영속성을 제공하기 위하여 스토리지 서비스를 제공한다. 스토리지는 볼륨으로 관리된다. 

볼륨은 파드 생명주기에 묶여 있는 스토리지로, 파드 내의 하나 이상의 컨테이너에서 사용할 수 있다. 쿠버네티스는 다양한 유형의 볼륨을 지원하며 하나의 파드는 여러 볼륨 유형을 동시에 사용할 수 있다. 임시 볼륨(Ephemeral)은 파드의 수명과 함께 삭제되지만 영구 볼륨(Persistent Volume)은 파드가 삭제되어도 유지된다.



##### 9.4.5.1 영구 볼륨(PersistentVolume)



영구 볼륨(PersistentVolume, PV)은 스토리지 리소스를 나타낸다. PV는 일반적으로 백업 스토리지 자원(Backing Storage Resource), NFS, GCEPersistentDisk, RBD 등과 연결된다. 이들의 생명주기는 Pod와 독립적으로 처리된다.

모든 PersistentVolume 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get Persistentvolume 또는 kubectl get pv
```



##### 9.4.5.2 영구 볼륨 클레임(PersistentVolumeClaim)



영구 볼륨 클레임(PersistentVolumeClaim, PVC)은 일련의 요구 사항을 충족하는 스토리지 요청이다. 일반적으로 동적 프로비저닝 스토리지와 함께 사용된다.

모든 PVC 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get Persistentvolumeclaim 또는 kubectl get pvc
```



##### 9.4.5.3 스토리지 클래스(StorageClass)



스토리지 클래스는 외부 스토리지 리소스 위에 있는 추상화이다. 각 스토리지클래스에는 해당 스토리지클래스에 속하는 퍼시스턴트볼륨을 동적으로 프로비저닝 할 때 사용되는 `provisioner`, `parameters` 와 `reclaimPolicy` 필드가 포함된다.

모든 스토리지 클래스 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get storageclass 또는 kubectl get sc
```



#### 9.4.6 구성정보(Configuration)



구성 파일들은 클러스터에 적용되기 전에 버전 컨트롤에 저장되어 있어야 한다. 이는 만약 필요하다면 구성의 변경 사항을 빠르게 되돌릴 수 있도록 해준다. 이는 또한 클러스터의 재-생성과 복원을 도와준다.

JSON보다는 YAML을 사용해 구성 파일을 작성한다. 비록 이러한 포맷들은 대부분의 모든 상황에서 통용되어 사용될 수 있지만, YAML이 좀 더 사용자 친화적인 성향을 가진다



##### 9.4.6.1 구성 맵(ConfigMap)



구성 맵은 쿠버네티스 내에 저장된 외부 데이터로 명령줄 아규먼트(Command Line Arguement),  환경 변수 또는 구성 파일에 사용할 수 있다. 6.2.2절에서 살펴보았던 외부화된 구성정보(Externalized Configuration) 저장소 패턴구현에 이상적인 방법이다.

모든 구성 맵 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get configmap 또는 kubectl get cm
```



##### 9.4.6.2 시크릿(Secret)



시크릿은 암호, 토큰 또는 키와 같은 소량의 중요한 데이터를 포함하는 오브젝트이다. 시크릿을 사용한다는 것은 사용자의 기밀 데이터를 애플리케이션 코드에 넣을 필요가 없음을 뜻한다. 구성 맵와 기능적으로 동일하지만 base64로 인코딩되고 설정에 따라 저장시 암호화된다.

모든 시크릿 목록을 조회하는 방법은 다음과 같다.



```shell
kubectl get secret
```



### 9.5 쿠버네티스 적용



쿠버네티스를 이해하기 위하여 쇼핑몰에서 사용하던 H2 데이터베이스를 PostgreSQL로 변경하고, 이를 쿠버네티스의 한 컨테이너로 설치해보자.

쇼핑몰 애플리케이션은 application.properties 파일에 있는 JDBC 드라이버, URL, 사용자 이름, 비밀번호 등의 속성들을 설치되는 PostgreSQL 정보로 변경하여야 하고, pom.xml에 PostgreSQL JDBC 드라이버를 추가해야 한다.



#### 9.5.1 애플리케이션을 쿠버네티스 형식으로 변경하기



먼저 pom.xml에 PostgeSQL을 추가하는 것으로 시작한다.



```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```



다음으로 애플리케이션.properties를 수정한다.



```properties
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.hibernate.ddl-auto=create
spring.datasource.url=jdbc:postgresql://${POSTGRES_SERVICE}:5432/${POSTGRES_DB_NAME}
spring.datasource.username=${POSTGRES_DB_USER}
spring.datasource.password=${POSTGRES_DB_PASSWORD}
```

다음과 같은 Environment Properties Placeholder들을 사용한다.

- POSTGRES_SERVICE : PostgreSQL DB 서버의 호스트
- POSTGRES_DB_NAME : PostgreSQL DB 이름
- POSTGRES_DB_USER : PostgreSQL 사용자 이름
- POSTGRES_DB_PASSWORD : PostgreSQL 암호

Kubernetes ConfigMap 및 Secret 객체에서 이러한 값들을 추출한다.



##### 9.5.1.1 구성 맵 생성



먼저 구성 맵을 만들어야한다.



```shell
$ kubectl create configmap postgres-config \
	--from-literal=POSTGRES_DB=shopping \
    --from-literal=POSTGRES_SERVICE=postgres
```



생성 된 구성 맵은 다음의 명령어로 확인할 수 있다.



```shell
$ kubectl get cm postgres-config -o yaml
apiVersion: v1
data:
  POSTGRES_DB_NAME: shopping
  POSTGRES_SERVICE: postgres
kind: ConfigMap
metadata:
  creationTimestamp: "2023-08-20T10:59:44Z"
  labels:
    app: postgres
  name: postgres-config
  namespace: default
  resourceVersion: "15437"
  uid: 62c737b9-3e08-4cca-92af-dc40b5f804c1
```



##### 9.5.1.2 시크릿 생성



다음으로 시크릿을 생성한다.



```shell
$ kubectl create secret generic db-security \
    --from-literal=POSTGRES_USER=postgres \
    --from-literal=POSTGRES_PASSWORD=postgres
```



생성된 시크릿을 다음의 명령어로 확인할 수 있다.



```shell
$ kubectl get secret db-security -o yaml
apiVersion: v1
items:
- apiVersion: v1
  data:
    POSTGRES_PASSWORD: cG9zdGdyZXM=
    POSTGRES_USER: cG9zdGdyZXM=
  kind: Secret
  metadata:
    creationTimestamp: "2023-08-20T10:59:44Z"
    labels:
      app: postgres
    name: db-security
    namespace: default
    resourceVersion: "15438"
    uid: 0c06dd40-4c2e-4fdb-a2c8-dc782aec9a72
  type: Opaque
kind: List
metadata:
  resourceVersion: ""
```



- 자격 증명은 base64로 인코딩된다. 이것은 우연히 누군가 해당 내용을 봐서 노출되거나 터미널 로그에 저장되지 않도록 시크릿을 보호하기 위한 것이다.
- 쿠버네티스의 관점에서 보면 이 시크릿의 내용은 관심이 없다. 단순히 임의의 키-값 쌍을 포함하고 있을 뿐이다.



##### 9.5.1.3 쿠버네티스에 PostgreSQL 배포



구성정보가 중앙 집중화되어 쿠버네티스 클러스터에 저장되므로 스프링 부트 애플리케이션과 지금 생성할 PostgreSQL 서비스간 구성정보를 공유 할 수 있다.

k8s/에 PostgreSQL 리소스 파일을 이미 준비했다. 이 YAML 파일에는 배포 및 서비스 리소스가 포함되어 있다.

구성 맵 및 시크릿에서 속성들을 로드한다.



아래 YAML 파일을 파일로 생성하여 적용한다.



```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres  # Sets Deployment name
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgres
          image: bitnami/postgresql:latest
          imagePullPolicy: "IfNotPresent"
          ports:
            - containerPort: 5432  # Exposes container port
          envFrom:
            - configMapRef:
                name: postgres-config
          env:
          - name: POSTGRES_USER
            valueFrom:
              secretKeyRef:
                name: db-security
                key: POSTGRES_USER
          - name: POSTGRES_PASSWORD
            valueFrom:
              secretKeyRef:
                name: db-security
                key: POSTGRES_PASSWORD
          volumeMounts:
            - mountPath: /var/lib/postgresql/data
              name: postgredb
      volumes:
        - name: postgredb
          persistentVolumeClaim:
            claimName: postgres-pv-claim
---
apiVersion: v1
kind: Service
metadata:
  name: postgres # Sets service name
  labels:
    app: postgres # Labels and Selectors
spec:
  type: NodePort # Sets service type
  ports:
    - port: 5432 # Sets port to run the postgres application
  selector:
    app: postgres
```



- image : bitnami에서 최신 postgresql 이미지를 사용한다.
- env 블록은 컨테이너 환경에서 데이터를로드하는 데 사용된다.
- db-security 시크릿에서 POSTGRES_USER이라는 키에서 로드 된 값으로 환경 변수를 만든다.
- db-security 시크릿에서 POSTGRES_PASSWORD이라는 키에서 로드 된 값으로 환경 변수를 만든다.
- postgres-config 구성맵에서 POSTGRES_DB 키에서 로드 된 값으로 환경 변수를 만든다.



이 YAML 파일을 쿠버네티스에 적용하려면 다음과 같이 수행한다.



```shell
$ kubectl create -f postgres.yml
deployment.apps/postgres created
service/postgres created
```



지금까지의 모든 과정이 잘되었는지는 아래의 명령어로 확인할 수 있다.



```sh
$ kubectl get all
NAME                            READY   STATUS    RESTARTS   AGE
pod/postgres-7dd49bb44b-tg9dm   1/1     Running   0          9s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.43.0.1       <none>        443/TCP          19h
service/postgres     NodePort    10.43.162.161   <none>        5432:30881/TCP   9s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/postgres   1/1     1            1           9s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/postgres-7dd49bb44b   1         1         1       9s
```



파드명이 확인되면 다음과 같이 PostgreSQL에 접속해볼 수도 있다.



```sh
$ kubectl exec -it postgres-7dd49bb44b-92qth --  psql -h localhost -U postgres --password -p 5432 shopping
```



생성 된 디플로이먼트는 아래 명령어로 확인할 수 있다.



```shell
$ kubectl get deployment postgres -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2023-08-20T11:44:42Z"
  generation: 1
  name: postgres
  namespace: default
  resourceVersion: "16838"
  uid: 52f173aa-5e71-4b91-b87b-3bbf3f621bb7
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: postgres
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: postgres
    spec:
      containers:
      - env:
        - name: POSTGRES_USER
          valueFrom:
            secretKeyRef:
              key: POSTGRES_USER
              name: db-security
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              key: POSTGRES_PASSWORD
              name: db-security
        envFrom:
        - configMapRef:
            name: postgres-config
        image: bitnami/postgresql:latest
        imagePullPolicy: IfNotPresent
        name: postgres
        ports:
        - containerPort: 5432
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /var/lib/postgresql/data
          name: postgredb
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      volumes:
      - name: postgredb
        persistentVolumeClaim:
          claimName: postgres-pv-claim
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2023-08-20T11:44:43Z"
    lastUpdateTime: "2023-08-20T11:44:43Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2023-08-20T11:44:42Z"
    lastUpdateTime: "2023-08-20T11:44:43Z"
    message: ReplicaSet "postgres-7dd49bb44b" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
```



생성 된 서비스는 다음의 명령어로 확인할 수 있다.



```shell
$ kubectl get service postgres -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2023-08-20T11:44:42Z"
  labels:
    app: postgres
  name: postgres
  namespace: default
  resourceVersion: "16828"
  uid: f109c282-cf3e-4a09-a5af-f9e257c43941
spec:
  clusterIP: 10.43.162.161
  clusterIPs:
  - 10.43.162.161
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - nodePort: 30881
    port: 5432
    protocol: TCP
    targetPort: 5432
  selector:
    app: postgres
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}
```







위 결과에는 흥미로운 내용들이 있다. 

- port 이 서비스를 사용할 수있는 포트
- targetPort : 서비스가 전달할 컨테이너 포트



우리는 이미 spring.datasource.url 속성에서 포트를 언급했다.

-  포트를 동적으로 지정하기 위해 Kubernetes의 강력한 기능을 사용한다면 어떻게 생각하는가?
- 좋다,하지만 어떻게? :)



이러한 리소스를 만든 후, Effective한 Property들은 다음과 같다.



```properties
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.hibernate.ddl-auto=create
spring.datasource.url=jdbc:postgresql://postgresql:5432/shopping
spring.datasource.username=postgres
spring.datasource.password=postgres
```



데이터 소스 URL은 postgresql이라는 호스트를 가리킨다. 호스트명을 IP로 지정하는 것은 쿠버네티스가 수행한다.

postgresql 서비스를 확인하려면 :

```shell
$ kubectl get svc postgres
NAME       TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
postgres   NodePort   10.43.162.161   <none>        5432:30881/TCP   7m4s
```



쿠버네티스에는 서비스 자체와 관련된 데이터를 가져올 수 있는 훌륭한 기능이 있다. 예를 들어 이 서비스에 연결된 포트를 가져올 수 있다. 예를 들면 :

- $ {postgres.service.host}는 10.111.244.143으로 확인된다.
- $ {postgres.service.port}는 5432로 확인된다.



이제 POSTGRES_SERVICE로 구성 맵을 설정하였으므로 쿠버네티스에 의해 지정되는 환경 변수를 이용하면 다음과 같이 설정할 수 있다.

- $ {postgresql.service.host}는 $ {$ {POSTGRES_SERVICE} .service.host}로 작성할 수 있다.
- $ {postgresql.service.port}는 $ {$ {POSTGRES_SERVICE} .service.port}로 작성할 수 있다.



application.properties에 구성정보에 설정된 내부 Placeholder는 구성 맵에서 제공하는 환경 변수에 의해 지정되며, 외부 Placeholder는 쿠버네티스에 의해 resolve된다.

최종적인 application.properties는 다음과 같다.



```properties
spring.datasource.driver-class-name = org.postgresql.Driver
spring.jpa.hibernate.ddl-auto = create
spring.datasource.url = jdbc:postgresql://${${POSTGRES_SERVICE}.service.host}\
:${${POSTGRES_SERVICE}.service.port}/${POSTGRES_DB}
spring.datasource.username=${POSTGRES_USER}
spring.datasource.password=${POSTGRES_PASSWORD}
```



이제 우리는 구성 맵을 이용하여 중독자가 되었다. 쿠버네티스의 구성 맵에 application.properties를 호스팅할 것이다. 이를 위하여 다음을 수행한다.

```shell
kubectl create configmap app-config
	--from-file=src/main/resources/application.properties
```



이제 스프링 부트 애플리케이션에서 application.properties를 어떻게 사용할 수 있는가?
스프링 클라우드 쿠버네티스 플러그인을 사용하면 된다.



##### 9.5.1.4 스프링 클라우드 구버네티스 란?



스프링 클라우드 Kubernetes 플러그인은 Kubernetes와 스프링 부트 간 통합을 구현한 것이다. Kubernetes API를 사용하여 ConfigMap의 Configuration 데이터에 대한 액세스를 제공한다.

Kubernetes ConfigMap을 스프링 부트 externalized configuration 메커니즘과 직접 통합하기 매우 쉽게 하여, 
Kubernetes ConfigMap이 스프링 부트 Configuration의 대체 속성 소스로 동작하도록하는 Configuration 메커니즘이다.

이 플러그인의 뛰어난 기능을 활성화하려면 :

1. Maven Dependency 추가
   아래 Dependency를 pom.xml에 추가한다.

   ```xml
   <dependency>
       <groupId>io.fabric8</groupId>
       <artifactId>spring-cloud-starter-kubernetes</artifactId>
       <version>0.1.6</version>
   </dependency>
   ```

   

2. 부트 스트랩 파일 생성

   src/main/resources 아래에 새 파일 bootstrap.properties를 만든다.

   ```properties
   spring.application.name = $ {project.artifactId}
   spring.cloud.kubernetes.config.name = app-config
   ```

   - $ {project.artifactId}는 maven-resources-plugin에 의해 파싱되고 채워진다.
     이 튜토리얼의 Github 저장소에서 호스팅되는 샘플 프로젝트의 pom.xml에서 찾을 수 있다.
   - 훌륭한 애플리케이션.properties를 저장한 ConfigMap의 이름.



이게 전부다. 스프링 클라우드 Kubernetes는 애플리케이션에 올바르게 통합되었다. 애플리케이션을 Kubernetes에 배포할 때에는, ConfigMap app-config에 저장된 애플리케이션.properties를 사용할 것이다.

배포는 어떻게 하는가?



##### 9.5.1.5 쿠버네티스에 배포



배포, 전체 내용을 다루자면 많은 챕터를 가질 수있는 긴 이야기지만 여기서는 짧고 간단히 다뤄보겠다.

정의에 따르면, 쿠버네티스는 컨테이너 오케스트레이션 솔루션이다. 따라서 애플리케이션을 쿠버네티스에 배포한다는 것은 다음을 의미한다.

- 애플리케이션 컨테이너화 : 애플리케이션을 포함하는 이미지 만들기
- 배포 리소스 준비 (Deployment, ReplicaSet 등 ...)
- 쿠버네티스에 컨테이너 배포

이 단계를 수행하는 데 시간이 걸릴 수 있다. 이 프로세스를 자동화하려고해도, 구현하는 데 오랜 시간이 걸리며 애플리케이션에 대한 모든 케이스와 변수들을 다루는 데 더 많은 시간이 걸린다.

이러한 작업이 너무 무거 우므로이 모든 작업을 쉽게 수행 할 수있는 도구가 필요한다.

이를 위한 매우 강력한 도구 인 Fabric8-Maven-Plugin이 있다.

![Fabric8 Logo](kubernetes/Fabric8%20Logo.PNG)

Fabric8-Maven-Plugin은 Docker, Kubernetes 및 OpenShift를 위한 Java 애플리케이션을 빌드하고 배포하기 위한 원스톱 상점(One-Stop-Shop)이다. Java 애플리케이션을 Kubernetes 및 OpenShift로 전달해준다. Maven과의 긴밀한 통합을 제공하고 이미 제공된 빌드 Configuration의 이점을 제공한다. 이는 세 가지 작업에 중점을 두고 있다.

- Docker 이미지 빌드
- OpenShift 및 Kubernetes 리소스 생성
- Kubernetes 및 OpenShift에 애플리케이션 배포

이 플러그인은 개발자 대신 모든 무거운 작업을 수행한다.

이 플러그인은 매우 유연하게 Configure할 수 있으며 다음을 생성하기 위한 여러 Configuration 모델을 지원한다.

- 의견이 있는 기본값이 미리 선택되는 빠른 램프 업을위한 **Zero Configuration**
- XML 구문의 플러그인 Configuration을 가진 **Inline Configuration**
- 플러그인으로 보강 된 실제 Deployment Descriptor의 **External Configuration** 템플릿
- Docker Compose 파일을 제공하고 docker compose deployment로 Kubernetes / OpenShift 클러스터에 배포를 수행하는 **Docker Compose Configuration**

프로젝트에서 fabric8-maven-plugin을 활성화하기 위하여  pom.xml plugin 섹션에 다음을 추가한다.

```xml
<plugin>
    <groupId>io.fabric8</groupId>
    <artifactId>fabric8-maven-plugin</artifactId>
    <version>3.5.41</version>
</plugin>
```

이제 fabric8-maven-plugin을 사용하여 빌드 또는 배포하기 위하여 Kubernetes 클러스터가 시작 및 실행되어 있는지 확인한다.

fabric8-maven-plugin은 원활한 Java 개발자 경험을 제공하기 위하여 다양한 종류의 goal들을 지원한다. 이러한 goal들은 다음과 같이 분류될 수 있다.

- 빌드 goal은 Docker 이미지와 같은 Kubernetes 빌드 아티팩트를 만들고 관리하는 데 사용된다.
  - fabric8:build : Docker 이미지 빌드
  - fabric8:resource : Kubernetes 리소스 descriptor 생성
  - fabric8:push : 레지스트리에 Docker 이미지 푸시
  - fabric8:apply : 실행중인 클러스터에 리소스 적용
- 개발 goal은 개발 클러스터에 리소스 descriptor를 배포하는 데 사용된다.
  - fabric8:run : 전체 개발 워크플로우 사이클(fabric8:resource → fabric8:build → fabric8:apply)을 foreground로 실행한다.
  - fabric8:deploy : 리소스 descriptor를 생성 한 후 앱을 빌드한 다음에 클러스터에 배포한다. Background에서 실행된다는 점을 제외하면 'fabric8 : run'과 동일하다.
  - fabric8:undeploy : 클러스터에서 리소스 descriptor를 배포 해제하고 제거한다.
  - fabric8:watch : 재구축 및 재시작 수행 감시

Maven 라이프사이클 단계에서 Goal을 통합하려는 경우 아래와 같이 쉽게 수행 할 수 있다.

```xml
<plugin>
    <groupId>io.fabric8</groupId>
    <artifactId>fabric8-maven-plugin</artifactId>
    <version>3.5.41</version>
    <!-- This block will connect fabric8:resource and fabric8:build to lifecycle phases -->
    <executions>
        <execution>
        <id>fmp</id>
        <goals>
            <goal>resource</goal>
            <goal>build</goal>
        </goals>
        </execution>
    </executions>
</plugin>
```

> Note
> fabric8-maven-plugin을 f8mp로 약어 표현하였다.

예를 들어 mvn clean install을 수행하면 플러그인이 도커 이미지를 빌드하고 ${basedir}/target/classes/META-INF /fabric8/kubernetes 디렉토리에 Kubernetes 리소스 descriptor를 생성한다.

생성 된 리소스 descriptor를 확인해 보자.

> Warning
> 잠깐만! ConfigMaps를 스프링 부트 애플리케이션에 전달할 것이라고 말했는데 어디에 있지?

그렇다. 리소스 설명자를 생성하기 전에 이를 f8mp에 알려야한다.

f8mp는이 작업을 쉽게 수행 할 수 있다. 플러그인은 일부 리소스Fragments을 처리 할 수 있다. 그것은
src/main/fabric8 디렉토리에있는 YAML 코드 조각을 의미한다. 각 리소스는 리소스 description의 골격을 포함한 자체 파일이다. 플러그인이 리소스를 가져와서 Enrich한 다음 모든 데이터를 결합한다. 이 Desciptor 파일들 내에서 모든 Kubernetes 기능을 자유롭게 사용할 수 있다.

본 샘플에서는 스프링 부트 애플리케이션이 실행될 Pod에 대한 환경 변수의 Configuration을 Resource Fragment에 전달할 것이다. 여기서는 Deployment에 대한 Fragment를 사용할 것이며 다음과 같이 표현된다. 

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: ${project.artifactId}
  namespace: default
spec:
  template:
    spec:
      containers:
        - name: ${project.artifactId}
          env:
          - name: POSTGRES_SERVICE
            valueFrom:
              configMapKeyRef:
                name: postgres-config
                key: postgres.service.name
          - name: POSTGRES_DB_NAME
            valueFrom:
              configMapKeyRef:
                name: postgres-config
                key: postgres.db.name
          - name: POSTGRES_DB_USER
            valueFrom:
              secretKeyRef:
                name: db-security
                key: db.user.name
          - name: POSTGRES_DB_PASSWORD
            valueFrom:
              secretKeyRef:
                name: db-security
                key: db.user.password
```

- 배포 및 컨테이너의 이름
- ConfigMap과 Secret에서 만들고 채우는 환경 변수

이제 f8mp가 리소스 설명자를 생성하려고 할 때 이 리소스 Fragment를 찾아서, 다른 데이터와 결합을 한다. 결과 Output은 이미 제공한 Fragment들과 일치한다.

자 이제 mvn clean install을 실행해보자.

```shell
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building MyBoutique 0.0.1-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
...
[INFO]
[INFO] --- fabric8-maven-plugin:3.5.41:resource (fmp) @ myboutique -
[INFO] F8: Running in Kubernetes mode
[INFO] F8: Running generator spring-boot
[INFO] F8: spring-boot: Using Docker image fabric8/java-jboss-openjdk8-jdk:1.3 as base / builder
[INFO] F8: using resource templates from /Users/n.lamouchi/MyBoutique/src/main/fabric8
[INFO] F8: fmp-service: Adding a default service 'myboutique' with ports [8080]
[INFO] F8: spring-boot-health-check: Adding readiness probe on port 8080, path='/health',
scheme='HTTP', with initial delay 10 seconds
[INFO] F8: spring-boot-health-check: Adding liveness probe on port 8080, path='/health',
scheme='HTTP', with initial delay 180 seconds
[INFO] F8: fmp-revision-history: Adding revision history limit to 2
[INFO] F8: f8-icon: Adding icon for deployment
[INFO] F8: f8-icon: Adding icon for service
[INFO] F8: validating ../classes/META-INF/fabric8/openshift/myboutique-svc.yml resource
[INFO] F8: validating ../classes/META-INF/fabric8/openshift/myboutique-deploymentconfig.yml resource
[INFO] F8: validating ../classes/META-INF/fabric8/openshift/myboutique-route.yml resource
[INFO] F8: validating ../classes/META-INF/fabric8/kubernetes/myboutique-deployment.yml resource
[INFO] F8: validating ../classes/META-INF/fabric8/kubernetes/myboutique-svc.yml resource
[INFO]
...
[INFO]
[INFO] --- fabric8-maven-plugin:3.5.41:build (fmp) @ myboutique -
[INFO] F8: Building Docker image in Kubernetes mode
[INFO] F8: Running generator spring-boot
[INFO] F8: spring-boot: Using Docker image fabric8/java-jboss-openjdk8-jdk:1.3 as base / builder
[INFO] Copying files to ../docker/nebrass/myboutique/snapshot-180XX/build/maven
[INFO] Building tar: ../docker/nebrass/myboutique/snapshot-180XX/tmp/docker-build.tar
[INFO] F8: [nebrass/myboutique:snapshot-180XX] "spring-boot":
Created docker-build.tar in 283 milliseconds
[INFO] F8: [nebrass/myboutique:snapshot-180XX] "spring-boot":
Built image sha256:61171
[INFO] F8: [nebrass/myboutique:snapshot-180XX] "spring-boot":
Tag with latest
[INFO]
...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 30.505 s
[INFO] Finished at: 2018-03-27T17:48:29+02:00
[INFO] Final Memory: 70M/721M
[INFO] ------------------------------------------------------------------------
```

- 감지 된 Configuration을 기반으로 리소스 설명자 생성 : 기존 Actuator Endpoint와 함께 포트 8080을 사용하는 스프링 부트애플리케이션.

- Kubernetes 모드로 Docker 이미지 빌드 (Openshift S2I Mechanism을 사용하여 빌드하는 Openshift 모드와 달리 로컬에서 수행)

프로젝트를 빌드 한 후에는 ${basedir}/target/classes/META-INF/fabric8/kubernetes 디렉토리에 아래와 같은 파일들이 있다.

- my-school-deployment.yml
- my-school-svc.yml



배포를 확인해 보겠다.



```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    fabric8.io/git-commit: 0120b762d7e26994e8b01d7e85f8941e5d095130
    fabric8.io/git-branch: master
    fabric8.io/scm-tag: HEAD
...
  labels:
    app: myboutique
    provider: fabric8
    version: 0.0.1-SNAPSHOT
    group: com.onepoint.labs
  name: myboutique
  namespace: default
spec:
  replicas: 1
  revisionHistoryLimit: 2
  selector:
    matchLabels:
      app: myboutique
      provider: fabric8
      group: com.onepoint.labs
  template:
    metadata:
      annotations:
        fabric8.io/git-commit: 0120b762d7e26994e8b01d7e85f8941e5d095130
        fabric8.io/git-branch: master
        fabric8.io/scm-tag: HEAD
        ...
      labels:
        app: myboutique
        provider: fabric8
        version: 0.0.1-SNAPSHOT
        group: com.onepoint.labs
    spec:
      containers:
      - env:
        - name: POSTGRES_SERVICE
          valueFrom:
            configMapKeyRef:
              key: postgres.service.name
              name: postgres-config
        - name: POSTGRES_DB_NAME
          valueFrom:
            configMapKeyRef:
              key: postgres.db.name
              name: postgres-config
        - name: POSTGRES_DB_USER
          valueFrom:
            secretKeyRef:
              key: db.user.name
              name: db-security
        - name: POSTGRES_DB_PASSWORD
          valueFrom:
            secretKeyRef:
              key: db.user.password
          name: db-security
        - name: KUBERNETES_NAMESPACE
          valueFrom:
            fieldRef:
            fieldPath: metadata.namespace
        image: nebrass/myboutique:snapshot-180327-003059-0437
        imagePullPolicy: IfNotPresent
        livenessProbe:
          httpGet:
            path: /health
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 180
        name: myboutique
        ports:
        - containerPort: 8080
          name: http
          protocol: TCP
        - containerPort: 9779
          name: prometheus
          protocol: TCP
        - containerPort: 8778
          name: jolokia
          protocol: TCP
        readinessProbe:
          httpGet:
            path: /health
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 10
        securityContext:
          privileged: false
```



- git-commit id 또는 git-branch와 같은 많은 유용한 데이터를 보유하는 생성 된 Annotation
- Label 섹션에는 Maven 프로젝트 그룹 ID, artifactId 및 버전 정보가 있다.
  여기에 provider = fabric8 Lable을 추가하여이 데이터가 f8mp에 의해 생성되었음을 알려준다.
- f8mp에 의해 생성 및 빌드 된 Docker 이미지. 접미사 snapshot-180327-003059-0437는 버전 태그를 할당하는 기본 형식이다.
- Liveness probe는 구성된 컨테이너가 아직 작동 중인지 확인한다.
- Readiness probe는 컨테이너가 Request를 처리 할 준비가되었는지 확인한다.

> Tip
> f8mp가 클래스 경로에서 Spring-Boot-Actuator 라이브러리를 감지했기 때문에 Liveness and readiness probe가 생성된다.



이 시점에서 mvn fabric8 : apply 명령을 사용하여 애플리케이션을 배포 할 수 있으며, 결과는 다음과 같다.



```shell
[INFO] --- fabric8-maven-plugin:3.5.41:apply (default-cli) @ myboutique ---
[INFO] F8: Using Kubernetes at https://192.168.99.100:8443/ in namespace default with manifest
/Users/n.lamouchi/Downloads/MyBoutiqueReactive/target/classes/META-INF/fabric8/kubernetes.yml
[INFO] Using namespace: default
[INFO] Updating a Service from kubernetes.yml
[INFO] Updated Service: target/fabric8/applyJson/default/service-myboutique.json
[INFO] Using namespace: default
[INFO] Creating a Deployment from kubernetes.yml namespace default name myboutique
[INFO] Created Deployment: target/fabric8/applyJson/default/deployment-myboutique.json
[INFO] F8: HINT: Use the command `kubectl get pods -w` to watch your pods start up
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 16.003 s
[INFO] Finished at: 2018-03-28T00:03:56+02:00
[INFO] Final Memory: 78M/756M
[INFO] ------------------------------------------------------------------------
```



클러스터에 존재하는 모든 리소스를 확인할 수 있다.



```shell
kubectl get all
```



이 명령은 기본 네임 스페이스의 모든 리소스 리스트를 조회한다. 출력은 다음과 같다.



```shell
NAME  				DESIRED	CURRENT	UP-TO-DATE 	AVAILABLE 	AGE
deploy/myboutique 	1 		1 		1 			1 			6m
deploy/postgresql	1 		1 		1 			1 			7m

NAME 						DESIRED CURRENT READY 	AGE
rs/myboutique-5dd7cbff98 	1 		1 		1 		6m
rs/postgresql-5f57747985 	1 		1 		1 		7m

NAME 							READY 	STATUS 		RESTARTS 	AGE
po/myboutique-5dd7cbff98-w2wtl 	1/1 	Running 	0 			6m
po/postgresql-5f57747985-8n9h6 	1/1 	Running 	0 			7m

NAME 			TYPE 		CLUSTER-IP 		EXTERNAL-IP PORT(S) 	AGE
svc/kubernetes 	ClusterIP 	10.96.0.1 		<none> 		443/TCP 	23m
svc/myboutique 	ClusterIP 	10.106.72.231 	<none> 		8080/TCP 	20m
svc/postgresql 	ClusterIP 	10.111.62.173 	<none> 		5432/TCP 	21m
```



> 팁
> K8s 대시 보드에 이러한 모든 리소스 리스트를 조회할 수 있다.



이러한 리소스들이 이전에 수행 한 단계를 통하여 생성되었다.



##### 9.5.1.6 동작 결과 확인



완료되었다. 애플리케이션과 필요한 모든 리소스를 배포했다. 그러나 우리는 어떻게 배포 된 애플리케이션에 접근 할 수 있을까? 

애플리케이션은 myboutique라는 Kubernetes 서비스 객체를 통해 접근할 수 있다.

myboutique 서비스가 무엇인지 확인하고 kubectl get svc myboutique를 입력하면 결과는 다음과 같다.



```shell
kubectl get svc myboutique

NAME 		TYPE 		CLUSTER-IP 		EXTERNAL-IP 	PORT(S) 	AGE
myboutique 	ClusterIP 	10.106.72.231 	<none> 			8080/TCP 	1d
```



서비스 유형은 ClusterIP이다. ClusterIP 란 무엇일까?

ClusterIP는 기본 ServiceType이다. 클러스터 내부 IP로 서비스를 노출하므로 클러스터 내에서만 연결할 수 있다.

따라서 서비스를 클러스터 외부에서 연결할 수 있어야하기 때문에 이 ServiceType을 사용할 수 없다. 그렇다면 다른 유형의 서비스가 있는가?

그렇다. ClusterIP 외에 세 가지 다른 유형의 서비스가 있다.

- NodePort : 각 노드의 IP에 정적 포트 (NodePort)로있는 서비스를 노출한다. NodePort 서비스가 라우팅할 ClusterIP 서비스는 자동으로 생성된다. <NodeIP> : <NodePort> 형식으로 요청하여 클러스터 외부에서 NodePort 서비스에 연결할 수 있다.
- LoadBalancer : 클라우드 공급자의 LoadBalancer 를 사용하여 외부에 서비스를 노출한다.
  외부 LoadBalancer 가 라우팅 할 NodePort 및 ClusterIP 서비스는 자동으로 생성된다.
- ExternalName : 해당 값과 함께 CNAME 레코드를 반환하여 서비스를 externalName 필드의 내용으로 매핑한다(예 : foo.bar.example.com).



> Tip
> 샘플 애플리케이션의 경우에서는 트래픽을 모든 노드에 걸쳐 리디렉션하는 LoadBalancer 서비스를 사용한다. 클라이언트는 LoadBalancer의 IP를 통해 LoadBalancer 서비스에 연결한다.



LoadBalancer가 샘플 애플리케이션의 ServiceType이된다. 그러나 이것을 f8mp에게 어떻게 알려줄 수 있을까?

두 가지 솔루션이 있다.

• 이전에했던 것처럼 Resource Fragment를 사용
• f8mp 플러그인의 XML 기반 Configuration 인 Inline Configuration을 사용



이번에는 Inline Configuration을 사용하여 f8mp에 LoadBalancer 서비스가 필요함을 알려주도록 하겠다.

f8mp 플러그인의 Configuration 섹션에서 Enricher를 선언한다.

Enricher는 Kubernetes 및 Openshift 리소스 객체를 생성하고 커스터마이징하는 데 사용되는 컴포넌트이다. f8mp에는 기본적으로 활성화되는 enricher 세트가 함께 제공된다. 이들 enricher들 중 하나로 서비스를 커스터마이징하는 데 사용되는 것이 fmp-service이다.



Configuration된 enricher가있는 f8mp는 다음과 같다.

```xml
<plugin>
    <groupId>io.fabric8</groupId>
    <artifactId>fabric8-maven-plugin</artifactId>
    <version>3.5.41</version>
    <configuration>
        <enricher>
            <config>
                <fmp-service>
                	<type>LoadBalancer</type>
                </fmp-service>
            </config>
        </enricher>
    </configuration>
    ...
</plugin>
```



mvn clean install fabric8 : apply를 사용하여 프로젝트를 빌드하고 다시 배포한 다음에 kubectl get svc myboutique를 사용하여 배포 된 서비스의 유형이 무엇인지 확인해 보자.



```shell
NAME 		TYPE 			CLUSTER-IP 		EXTERNAL-IP 	PORT(S) 		AGE
myboutique 	LoadBalancer 	10.106.72.231 	<pending> 		8080:31246/TCP 	2d
```

> Warning
> EXTERNAL-IP 열에 표시된 <pending>은 minikube를 사용하고 있기 때문이다.



자 이제 애플리케이션에 어떻게 액세스 할 수 있는가? 배포 된 애플리케이션의 URL을 어떻게 얻을 수 있는가?

대답은 다음 질문보다 간단하다. minikube에 아래와 같이 입력하여 배포 된 앱의 URL을 가져온다.



```shell
open $(minikube service myboutique --url)
```



이 명령은 기본 브라우저를 통하여 스프링 부트 애플리케이션의 URL에 접속한다.



> Tip
> minikube service myboutique --url 명령은 스프링 부트 애플리케이션을 가리키는 myboutique 서비스의 경로를 제공한다.



배포 된 앱의 Swagger UI에 어떻게 액세스 할 수 있는가?



```shell
open $(minikube service myboutique --url)/swagger-ui.html
```



위의  명령은 기본 브라우저를 통하여 스프링 부트 애플리케이션의 URL에 접속한다.

![Landing Page of the deployed application on Kubernetes](kubernetes/Landing%20Page%20of%20the%20deployed%20application%20on%20Kubernetes.PNG)



#### 9.5.2 쿠버네티스 이후 마이크로서비스 패턴에 대한 재검토



이 부분이 저자가 책에서 가장 좋아하는 부분이다. 이 책을 쓰기 시작한 이후로 이 부분에 대하여 작성하기를 고대하고 있었다.

이 부분에서는 이전에 작성한 많은 컴포넌트를 제거하고 쿠버네티스컴포넌트로 대체한다.

> 로마에 있을 때에는 로마인처럼 행동하라
> – 출처 미상



스프링 클라우드 생태계는 쿠버네티스 클러스터와 상호 작용하는 많은 도구를 제공하는 라이브러리 세트로 된 스프링 클라우드 쿠버네티스라는 프로젝트를 인큐베이팅하고 있다.



##### 9.5.2.1 서비스 탐색과 등록



쿠버네티스는 훌륭한 서비스 검색 기능을 제공한다. 이러한 기능을 사용하여 Eureka를 제거 할 수 있다. 배포한 마이크로서비스를 쿠버네티스가 찾을 수 있게 한다.

이전에 이야기한 많은 쿠버네티스컴포넌트 중에 어떤 것이 Service Discovery를 위하여 사용되는가? 

답은 바로 서비스이다. 좀 더 설명해 보겠다.

이 장의 첫 번째 부분에서 이미 스프링 부트 애플리케이션을 쿠버네티스에서 실행하는 방법을 살펴 보았다.

샘플 애플리케이션은 쿠버네티스 Pod 내에서 실행되는 Docker 컨테이너에서 실행된다. 컨테이너화 된 샘플 애플리케이션은 Hazelcast 캐시 엔진 또는 DB와 같은 다른 Pod의 다른 애플리케이션과 통신해야 한다. 다음 다이어그램은 그 예제에 대하여 설명한 것이다.

![Application running in a Container inside a Pod - Communication with Services](kubernetes/Application%20running%20in%20a%20Container%20inside%20a%20Pod%20-%20Communication%20with%20Services.PNG)

DB 인스턴스는 어떤 이유로든 Crash되거나 재기동될 수 있는 Pod에서 실행 중이기 때문에, Eureka를 갖고 있다면 새로운 인스턴스가 기동된 후에 서비스를 계속할 수 있다. 쿠버네티스서비스는 동일한 기능을 제공한다. db-svc 객체는 DB Pod를 가리키고 있다. 새 DB Pod가 생성되면 자동으로 db-svc로 추적되는 pod로 클러스터 데이터에 등록된다.

db-svc 서비스는 app = sample-app selector를 사용하여 DB Pod를 추적한다. 마이크로서비스를 컨테이너로 배포 하면 Pod를 서비스로 노출하여 쉽게 추적 할 수 있다. 샘플 마이크로서비스에서는 서비스 이름으로 멀리 떨어진 마이크로서비스를 계속 호출하면, 쿠버네티스 내의 임베디드 DNS 서버는 배포된 Pod가 있는 동일한 네임 스페이스에서 서비스 이름을 확인한다. 따라서 Eureka 나 다른 라이브러리 또는 Configuration이 필요하지 않다.

쿠버네티스에는 kube-dns라는 특수 Pod가 있으며 이 Pod는 kube-system 네임 스페이스에 있다. 이 Pod는 쿠버네티스클러스터에서 서비스 이름을 확인하는 컴포넌트이다.

> Environment Variable을 이용한 서비스 검색
> Environment Variable을 이용한 Service Discovery의 다른 옵션이 있다. 이는  Pod가 생성 될 때 각 활성 서비스에 대한 환경 변수 세트를 주입하는 것이다. 이 옵션은 권장되지 않는다. DNS 기반 서비스 검색이 더 좋다.



###### 쿠버네티스 지원 Discovery 라이브러리 참여



###### Step 1 : Eureka 클라이언트 Dependency 제거



이미 Eureka를 사용하지 않을 것이라고 언급 했으므로 더 이상 Eureka Client에 대한 dependency가 필요하지 않다.



```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```



> 또한 애플리케이션.properties | yaml 파일에서 모든 Eureka 속성을 제거해야한다.



###### Step 2 : 쿠버네티스 지원 검색 라이브러리 추가



스프링 클라우드 쿠버네티스 라이브러리에는 스프링 클라우드 쿠버네티스 Discovery라는 라이브러리가 포함되어 있다. 이 라이브러리를 사용하면 쿠버네티스 Services를 이름으로 조회할 수 있다.

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-kubernetes-discovery</artifactId>
</dependency>
```



###### Step 3 : 쿠버네티스 서비스 이름 정의



일부 스프링 클라우드 컴포넌트는 서비스 인스턴스에 대한 정보를 얻기 위해 DiscoveryClient를 사용한다. 이 작업을 수행하려면 서비스 이름이 spring.application.name property 값과 동일한 지 확인해야한다.

이를 위해서 다음 Configuration 태그를 f8mp에 추가해야한다.

```xml
<plugin>
    <groupId>io.fabric8</groupId>
    <artifactId>fabric8-maven-plugin</artifactId>
    <version>3.5.41</version>
    <configuration>
        <enricher>
            <config>
                <fmp-service>
                    <name>${project.name}</name>
                    ...
                </fmp-service>
            </config>
        </enricher>
    </configuration>
    ...
</plugin>
```

플러그인 enricher의 config.fmp-service.name property에 ${project.name} 값을 설정한다.
이 ${text} 태그는 Maven에서 파싱되고 대체된다. 이렇게 하면 서비스 이름은 Maven 프로젝트 이름이된다.

다음으로 Maven 프로젝트 이름으로 spring.application.name을 정의해야 한다.  이를 위하여 이 Configuration을 Maven Build 태그에 추가해야한다.

```
<build>
    <resources>
        <resource>
            <directory>src/main/resources</directory>
            <filtering>true</filtering>
            <includes>
            	<include>애플리케이션.properties</include>
            </includes>
        </resource>
    </resources>
<plugins>
...
</build>
```



그리고 애플리케이션.properties 파일에서 프로젝트명을 정의한다.



```properties
spring.application.name = @project.name@
```



이제 spring.application.name과 쿠버네티스 서비스 이름이 동일한 값, 즉 Maven project.name으로 설정된다. 



##### 9.5.2.2 Load Balancing



이전에 Zuul, Eureka 및 Ribbon을 사용하여 마이크로서비스 간의 호출에서 부하 분산을 수행했지만, Kubenetes 세계에 있을 때에는 이들을 유지하는 어떤 개념이 있을까? 

예를 들어 이전 스키마에서 Hazelcast 캐시는 두 개의 인스턴스, 즉 서로 다른 두 개의 Pod로 실행된다.



###### 서버 측 Load Balancing



Kubernetes는 이미 서비스 개념에 로드 밸런싱 기능을 포함하여 이를 수행한다. 서비스는 호출 시 부하가 분산되어 가용한 인스턴스들 사이에서 적절한 Pod로 Redirect하는 단일 연결 창구를 제공한다. 서비스에 REST 호출만 하면 Kubernetes는 Request를 관련 Pod로 다시 라우팅한다.

Hazelcast를 처리하려면 hazelcast-svc를 호스트 이름으로 지정하면, Kubernetes는 두 개의 가용한 Hazelcast Pod 간의 Request에 대한 Load Balancing을 보장한다.



###### 클라이언트 측 Load Balancing



우리는 이미 스프링 클라우드 Netflix Ribbon을 사용했다. spring-cloud-kubernetes 프로젝트에서는
spring-cloud-kubernetes-ribbon이라는 Kubernetes 전용 Ribbon 버전이 있다.

spring-cloud-kubernetes-ribbon 프로젝트 내에는 서비스 Endpoint에 대한 정보가 포함된 Ribbon 서버 목록을 전달하는  Kubernetes 클라이언트가 있다. 이 ServerList는 Load Balancing된 클라이언트에서 편리하게 서비스 Endpoint에 액세스하는 데 사용된다.

Discovery Feature는 스프링 클라우드 Kubernetes Ribbon 프로젝트에서 Load Balancing할 애플리케이션에 대해 정의 된 Endpoint 목록을 가져 오기 위하여 사용된다.



##### 9.5.2.3 Externalized Configuration



우리는 이미 ConfigMap 객체를 사용하여 애플리케이션의 일부 속성을 저장했으며 암호 및 자격 증명을 저장하기 위하여 Secret을 사용하고 있다. 이러한 값을 컨테이너에 주입하고 환경 변수로 사용할 수 있다.

ConfigMaps 및 Secrets로 Config Server를 쉽게 대체 할 수 있다.

이 프로젝트는 ConfigMap과의 통합을 제공하여 config map들을 스프링 부트에서 액세스 할 수 있도록한다.

활성화된 ConfigMap PropertySource는 Kubernetes에서 애플리케이션 뒤의 name(즉, spring.application.name)으로 ConfigMap을 찾는다. Config map이 발견되면 데이터를 읽고 다음을 수행한다.

- 개별 Configuration Property를 적용
- 애플리케이션.yaml의 property 내용을 yaml로 적용
- 애플리케이션.properties라는 property 내용을 property 파일로 적용



###### ConfigMap으로 Config Server 교체



###### Step 1 : 스프링 클라우드 Config footprint 제거



pom.xml 파일에서 스프링 클라우드 Config dependency을 제거해야 한다.

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-config</artifactId>
</dependency>
```

다음으로 bootstrap.yml 파일에서 스프링 클라우드 Config 속성을 제거해야한다.

```yaml
spring:
  cloud:
    config:
      uri: http://localhost:8888
```



###### Step 2 : Maven dependency 추가



스프링 부트 애플리케이션이 Config Server 대신 ConfigMaps를 사용하도록하려면 두 가지 dependency을 추가해야한다.

ConfigMaps에 대한 스프링 클라우드 Kubernetes Maven dependency

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-kubernetes-core</artifactId>
    <version>0.3.0.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-kubernetes-config</artifactId>
    <version>0.3.0.RELEASE</version>
</dependency>
```



###### Step 3 : 애플리케이션 특성 파일을 기반으로 ConfigMap 작성



모든 애플리케이션.properties | yaml 파일에 대한 ConfigMap을 만들어야한다. 이를 위해서 마이크로서비스의 property를 갖고 있는 config-server/src/main/resources/configurations/ 폴더로 이동한다. 

모든 파일에 대해 property 파일과 동일한 이름을 가진 전용 ConfigMap을 만들어야 한다. 예를 들어, order-service.yml 파일을 기반으로 order-service라는 ConfigMap을 생성한다.

```shell
kubectl create configmap order-service --from-file=애플리케이션.properties=order-service.yml
```

이 명령은 order-service.yml을 기반으로 order-service라는 ConfigMap을 생성한다. spring-cloud-kubernetes-config 라이브러리는 spring.application.name property와 동일한 이름을 가진 ConfigMap을 찾는다.

ConfigMap의 키는 애플리케이션.properties이다. 이 키는 스프링 부트 애플리케이션이 실제 애플리케이션.properties 파일처럼 ConfigMap 값을 처리 할 수 있도록 한다.



###### Step 4 : ServiceAccount가 ConfigMap에 접근하기 위한 권한 부여



명시적으로 정의하지 않은 기본 계정으로 동일한 네임 스페이스에서 ConfigMap에 액세스하기 위하여 ServiceAccount에 권한을 부여해야 한다. 그래서 서비스 계정은 default : default이다.

```shell
kubectl create clusterrolebinding configmap-access --clusterrole view --serviceaccount=default:default
```

이제 통합을 최적화하자.



###### Step 5 : Boosting 스프링 클라우드 Kubernetes Configuration



스프링 클라우드 Config Server integration에는 애플리케이션이 새로운 Configuration 반영하기 위하여 외부 자산 소스의 변경 사항을 감지하고 내부 상태를 업데이트할 수 있도록 하는 훌륭한 기능이 있다.

스프링 클라우드 Kubernetes에도 동일한 기능이 존재하여 관련 ConfigMap 또는 Secret이 변경 될 때 애플리케이션 reload를 트리거 할 수 있다.

이 기능은 기본적으로 비활성화되어 있으며 애플리케이션.properties 파일의 configuration property를 사용하여 활성화 할 수 있다.

```properties
spring.cloud.kubernetes.reload.enabled = true
```

다음과 같은 레벨의 Reload가 지원된다(spring.cloud.kubernetes.reload.strategy property).

- refresh(default) : @ConfigurationProperties 이나  @RefreshScope Annoation이 달린 Configuration Bean 만 Reload된다. 이 Reload 레벨은 스프링 클라우드 Context의 새로 고침 기능을 활용한다.
- restart_context : 전체 Spring 애플리케이션Context가 Gracefully restart된다. Bean들은 새로운 Configuration으로 다시 생성된다.
- shutdown : 컨테이너 재시작을 활성화하기 위하여 Spring 애플리케이션Context가 종료된다. 이 레벨을 사용할 때 모든 비 데몬 스레드의 생명주기가 애플리케이션Context에 바운드되어 있고  Replcation Contoller나 Replica Set가 Pod를 다시 시작하도록 Configuration되었는지 여부를 확인하여야 한다.

Reload 기능은 두 가지 작동 모드를 지원한다.

- event(default) : Kubernetes API(웹 소켓)를 사용하여 Configuration 맵 또는 비밀의 변경 사항을 감시한다. 변경사항이 발생한 경우에 모든 이벤트는 Configuration을 다시 확인하고 Reload한다. Config map을 확인하기 위하여 서비스 계정은 view 역할이 필요하다. Secret에 대해서는 더 높은 수준의 역할(즉, edit)이 필요하다(default로는 Secret을 모니터링하지 않는다).
- polling : config map과 secret이 변경되었는지 주기적으로 확인하여 Configuration을 다시 생성한다. polling 주기는 property를 사용하여 Configuration 할 수 있다. 그 property 명은 spring.cloud.kubernetes.reload.period이며 기본값은 15 초이다. 그것은 모니터링되는 propety source와 동일한 역할이 필요하다. 이는 예를 들어 파일에 마운트된 Secret source에 대한 polling을 사용하면 특정 권한이 필요하지 않다는 의미이다.

스프링 클라우드 Kubernetes Reload property들은 다음과 같다 :

![스프링 클라우드 Kubernetes Reload properties](images/스프링 클라우드 Kubernetes Reload properties.png)

Notes :

- spring.cloud.kubernetes.reload의 Property들은 config map이나 secret으로 사용해서는 안된다. 런타임에 이러한 속성을 변경하면 예기치 않은 결과가 발생할 수 있다.
- Reload Strategy를 refresh 레벨을 사용할 때, Property 또는 전체 Configuration 맵을 삭제해도 Bean의 원래 상태로 복원되지는 않는다.
  



##### 9.5.2.4 Log aggregation



이미 ELK (Elasticsearch, Logstash, Kibana)를 사용했다. EFK는 Logstash를 Fluentd로 대체한 동일한 스택이다. 그렇다면 Logstash를 Fluentd로 대체하는 이유는 무엇일까?

우선, Kubernetes, Prometheus 등과 같은 다른 많은 프로젝트와 마찬가지로 설정이 매우 쉽고, 플러그인이 많으며 메모리 사용량이 매우 적다.

Fluentd는 데이터를 더 잘 사용하고 이해할 수 있도록 데이터 수집과 소비를 통합 할 수있는 오픈 소스 데이터 수집기이다. Fluentd는 Kubernetes 프로젝트와 가까운 클라우드 Native Computing Foundation에서 활발한 프로젝트이다. Fluentd는 Logstash보다 훨씬 더 Kubernetes와의 통합을 제공한다. 이것은 Kubernetes에서 Fluentd를 설치하고 사용하는 것이 Logstash를 사용하는 것보다 쉽다는 것을 의미한다.

> 이 튜토리얼에서는 분산 아키텍처의 에지 호스트 또는 장치의 에이전트로 설치할 수있는 경량의 배송자인 FluentBit을 사용한다. 이는 collector와 forwarder 역할을 하며, 성능을 우선으로 설계되었다.



###### Step 1 : Minikube 준비



Default Configuration은 동시에 다수의 Pod를 실행하기에는 상대적으로 부족하기 때문에 Minikube에 대한 Custom Configuration이 필요하다.



> 기본 Minikube Configuration
> Minikube에는 사용자 정의 Configuration이 정의되지 않은 경우 사용되는 기본 Configuration이 있다.
>
> - DefaultMemory는 2048m
> - DefaultCPUS는 2 cpu
> - DefaultDiskSize는 20g
>
> 필요한 경우 필요에 맞게 이러한 값을 재정의한다.



이전 Kubernetes 클러스터를 삭제해야 한다.



```shell
minikube delete --force
```



8GB의 메모리가 필요하다.



```shell
minikube config set memory 8192
```



3 개의 CPU가 필요하다.



```shell
minikube config set cpus 3
```



###### Step 2 : Helm을 사용하여 EFK 설치



Kubernetes 클러스터에 EFK 스택을 설치하기 위해 Helm을 사용한다.



> Helm이란?
>
> Helm은 개발자와 운영자가 애플리케이션 및 서비스를 Kubernetes 클러스터에 보다 쉽게 패키징, Configuration 및 배포 할 수 있도록하는 Kubernetes 용 패키지 관리자이다.
>
> Helm은 이제 공식 Kubernetes 프로젝트이며 Kubernetes 생태계 내부 및 주변의 오픈 소스 프로젝트를 지원하는 비영리 단체인 클라우드 Native Computing Foundation의 한 부분이다.
>
> Helm은 다음을 수행 할 수 있다.
>
> - 소프트웨어 설치
> - 소프트웨어 dependency에 따라 자동 설치
> - 소프트웨어 업그레이드
> - 소프트웨어 배포의 Configuration
> - 리포지토리에서 소프트웨어 패키지를 Fetch
>
> Helm은 다음 컴포넌트를 통해 이 기능을 제공한다.
>
> - 모든 Helm 기능에 대한 사용자 인터페이스를 제공하는 명령 줄 도구 helm 
> - Kubernetes 클러스터에서 실행되며, helm의 명령을 수신하고 클러스터에 소프트웨어 릴리스 Configuration 및 배포를 처리하는 연관 서버 컴포넌트 인 tiller
> - 차트라고하는 Helm 패키징 형식
> - 인기있는 오픈 소스 소프트웨어 프로젝트용 차트가 사전 패키징 된 공식 큐레이팅 된 차트 저장소
>
> Helm 차트 란?
>
> Helm 패키지를 차트라고하며 몇 개의 YAML Configuration 파일과 Kubernetes 매니페스트 파일로 렌더링되는 일부 템플릿으로 구성되어 있다. 
>
> helm 명령은 로컬 디렉토리 또는 디렉토리 구조의 패키지 버전인 .tar.gz에서 차트를 설치할 수 있다. 
>
> 이러한 패키지 차트는 차트 저장소에서 자동으로 다운로드하여 설치할 수도 있다.



Step 2.1 : Helm 준비



먼저 Helm Tiller 컴포넌트를 설치해야한다. Tiller는 Helm의 클러스터 내 컴포넌트이다. Kubernetes API 서버와 직접 상호 작용하여 Kubernetes 리소스를 설치, 업그레이드, 쿼리 및 제거한다. 릴리스를 나타내는 개체도 저장한다.

클러스터에 틸러 Pod를 배포하려면 :



```shell
helm init
```



> 틸러 Pod는 kube-system 네임 스페이스에 생성된다.



다음 명령으로 틸러 Pod가 실행 중인지 확인한다.



```shell
kubectl get pods -n kube-system -w

NAME 							READY 	STATUS 	RESTARTS 	AGE
...
tiller-deploy-845cffcd48-mh8vl 	1/1 	Running 0 			1m
```



Step 2.2 : 차트 저장소 추가



여기서는 훌륭한 개발자이자 블로거 인 Alen Komljen(https://akomljen.com/get-kubernetes-logs-with-efk-stack-in-5-minutes/)이 만든 훌륭한 EFK 차트를 사용할 것이다.

Helm 저장소에 그의 저장소를 추가해야한다.



```shell
helm repo add akomljen-charts \
	https://raw.githubusercontent.com/komljen/helm-charts/master/charts/
```



###### Step 3 : Elasticsearch Operator 설치



Operator 정의부터 시작해보자. Kubernetes Operator 는 기본적으로 특정 서비스 운영을 위해 사용자 지정 비즈니스 로직을 생성하기 위한 Custom Resource Definition(CRD)로 등록되는 사용자 지정 API 개체이다. Operator는 애플리케이션을 안정적으로 관리하기 위한 인간의 소프트웨어 운영 지식을 의미한다.

Elasticsearch Operator 설치는 다음과 같다.



```shell
helm install --name es-operator \
	--namespace logging \
	akomljen-charts/elasticsearch-operator
```



Elasticsearch Operator를 배포 한 후 새로운 CustomResourceDefinition(CRD)을 확인할 수 있다.



```shell
kubectl get crd

NAME 										CREATED AT
elasticsearchclusters.enterprises.upmc.com 	2018-11-02T20:37:02Z
```



이 CRD의 세부 사항을 확인하려면 다음을 수행하면 된다.



```shell
kubectl describe crd elasticsearchclusters.enterprises.upmc.com

Name: 			elasticsearchclusters.enterprises.upmc.com
Namespace:
Labels: 		<none>
Annotations: 	<none>
API Version: 	apiextensions.k8s.io/v1beta1
Kind: 			CustomResourceDefinition
Metadata:
...
Spec:
...
    Group:	enterprises.upmc.com
    Names:
        Kind: 		ElasticsearchCluster
        List Kind: 	ElasticsearchClusterList
        Plural: 	elasticsearchclusters
        Singular: 	elasticsearchcluster
    Scope: 			Namespaced
    Version: 		v1
...
```



보다시피 ElasticsearchCluster라는 새로운 종류의 리소스가 있다. 이 CRD는 Elasticsearch 클러스터를 만들 때 사용된다.



###### Step 4 : Helm을 사용하여 EFK 스택 설치



클러스터에 필요한 CustomResourceDefinition을 배포 한 후 EFK 스택을 설치하려면 다음 명령을 입력하면된다.



```shell
helm install --name efk \
	--namespace logging \
	akomljen-charts/efk
```



> 이 작업은 Docker 이미지가 저장소에서 가져 오고 Kubernetes에 배포하는 시간으로 몇 분 정도 소요된다.



다음 명령을 입력하여 모든 서비스가 생성되고 실행되고 있는지 확인할 수 있다.



```shell
kubectl get pods -n logging -w

NAME 												READY 	STATUS 	RESTARTS 	AGE
efk-kibana-fc4bbccb7-57kzp 							1/1 	Running 0 			5m
es-client-efk-cluster-857fd4c567-w4qw8 				1/1 	Running 0 			5m
es-data-efk-cluster-default-0 						1/1 	Running 0 			5m
es-master-efk-cluster-default-0 					1/1 	Running 0 			5m
es-operator-elasticsearch-operator-fbbd9556c-vdq4r 	1/1 	Running 0 			37m
fluent-bit-mfq2m 									1/1 	Running 0 			5m
```



몇 분 후에 모든 서비스가 실행되고 있어야한다. Kibana 서비스에 액세스 할 Ingress를 만든다.



```yaml
kind: Ingress
apiVersion: extensions/v1beta1
metadata:
  name: kibana-public
  annotations:
    ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - host: efk-kibana.info
      http:
        paths:
          - path: /
            backend:
              serviceName: efk-kibana
              servicePort: 5601
```

efk-kibana.info로 정의된 호스트에 액세스하려면 다음을 수행하면 된다.

```shell
echo "$ (minikube ip) efk-kibana.info"| sudo tee -a /etc/hosts
```

이 명령은 efk-kibana.info에서 Kibana 서비스에 접근 할 수 있도록한다.

![Kibana console reacheable on efk-kibana.info](kubernetes/Kibana%20console%20reacheable%20on%20efk-kibana.info.PNG)

그런 다음 대시 보드 메뉴 항목으로 이동하여 인덱스를 kubernetes_cluster *로 Configuration한다.

![Create index pattern - Step 1](kubernetes/Create%20index%20pattern%20-%20Step%201.PNG)

다음으로 @timestamp를 선택하면 Kibana가 준비된다.

![Create index pattern - Step 2](kubernetes/Create%20index%20pattern%20-%20Step%202.PNG)

Kubernetes 클러스터에있는 모든 네임 스페이스의 모든 로그가 표시되어야 한다. 풍부한 Kubernetes 메타 데이터 또한 포함되어 있을 것이다

![Kibana - Discover](kubernetes/Kibana%20-%20Discover.PNG)

이제 모든 Pod 로그가 이제 Kibana에서 중앙 집중화된다.



###### Step 5 : Broadcasting Appenders 제거



Logstash에 로그를 브로드 캐스트하는 로그 어펜더가 더 이상 필요하지 않다. 그 이유는 간단하다. 실제 로그 집계 메카니즘은 Fluent Bit를 사용하여 도커 컨테이너에서 로그를 Elasticsearch로 전송한다. 따라서 콘솔 어 펜더 만 유지한다.

브로드 캐스팅 log appender를 정의하므로 LoggingConfiguration.java 클래스를 삭제해야한다.

표준 출력 (콘솔)에 코드를 작성하는 Logstash 어 펜더를 추가해야한다. 이를 위해서 logback.xml을 각 마이크로서비스의 src/main/resources/ 폴더에 추가한다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
        	<pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>
    <include resource="org/springframework/boot/logging/logback/base.xml" />
    <logger name="org.hibernate.validator" level="info" />
    <logger name="org.springframework.cloud.kubernetes" level="debug" />
    <root level="info">
    	<appender-ref ref="STDOUT" />
    </root>
</configuration>
```

이 Configuration 파일을 사용하면 애플리케이션이 EFK 스타일과 일관된 방식으로 로그를 작성할 수 있다.



##### 9.5.2.5 Health check API



이 책의 마이크로서비스는 스프링 부트 Actuator 라이브러리를 사용하여 실행중인 애플리케이션에 대한 운영 정보(상태, 메트릭 등)를 노출한다.

스프링 부트 Actuator는 OK 일 때 UP 값을 반환하고 뭔가 잘못되었을 때 DOWN 값을 반환하는 /health Endpoint와 같은 몇 가지 유용한 Endpoint를 노출한다. 

Kubernetes는 이미 운영 정보 Endpoint를 다루는 동일한 사고 방식을 가지고 있다. Kubernetes에는 ReadinessProbe 및 LivenessProbe 두 가지 유형의 Probe가 있다.

- Readiness Probe는 컨테이너가 트래픽 수신을 시작할 준비가되었는지 확인하는 데 사용된다. 모든 컨테이너가 준비되면 Pod는 준비된 것으로 간주된다. 이 신호의 한 가지 용도는 서비스의 백엔드로 사용되는 Pod를 제어하는 것이다. Pod가 준비되지 않은 경우 서비스 Load Balancer에서 제거된다.
- Liveness Probe는 컨테이너를 언제 재시작하였지는 데 사용된다. 예를 들어, Liveness Probe는 애플리케이션이 실행 중이지만 진행할 수없는 데드락을 포착 할 수 있다.
  이러한 상태에서 컨테이너를 다시 시작하면 버그에도 불구하고 애플리케이션의 가용성을 높일 수 있다.

활성 상태 및 준비 상태 프로브는 애플리케이션이 Kubernetes 클러스터에서  정상상태로 유지되는지 확인하는 훌륭한 방법이다.



###### Actuator가 Kubenetes 영역에 도착하면 무엇이 바뀌는가?



해결책은 Liveness 및 Readiness 프로브를 Actuator 상태 Endpoint와 페어링하는 것이다. 이것은 스프링 부트 / 클라우드 애플리케이션과 Kubernetes 클러스터 사이의 높은 수준의 일관성을 보장한다.

아이디어는 스프링 부트 Actuator endpoint를 Kubernetes의 Liveness 및 Readiness Probe로 등록하는 것이다.

이 작업은 훌륭한 f8mp 플러그인에 의해 deployment.yaml 파일을 자동으로 생성하고, generator가  애플리케이션에서 스캔된 Property들로  Kubernetes의 Liveness 및 Readiness Probe를 포인팅하도록 추가한다. Generator가 spring-boot-starter-actuator dependency를 감지 할 때, f8mp enricher는 스프링 부트를 위한 Kubernetes Readiness 및 Liveness Probe를 추가한다.

f8mp 플러그인에 의해 생성 된 Kubernetes Resoure Descriptor를 확인하면 Readiness 및 Liveness Probe가 있다.
target/classes/META-INF/fabric8/kubernetes/deployment.yml

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
...
spec:
...
  template:
...
    spec:
      containers:
      - env:
      ...
      livenessProbe:
        httpGet:
          path: /actuator/health
          port: 8080
          scheme: HTTP
        initialDelaySeconds: 180
      ...
      readinessProbe:
        httpGet:
          path: /actuator/health
          port: 8080
          scheme: HTTP
        initialDelaySeconds: 10
...
```

자, 이제 다음 패턴으로 넘어가자.



##### 9.5.2.6 API Gateway



API Gateway는 API 앞에 위치하여 정의 된 마이크로서비스 그룹에 대한 단일 Entry Point 역할을 하는 프로그래밍 Facade이다.

API Gateway를 구현하기 위하여 스프링 클라우드 Netflix Zuul을 사용하였다. 그러면 Kubernetes의 어떤 기능이 이를 대체 할 수 있을까?

Kubernetes Ingress는 일반적으로 HTTP 인 클러스터의 서비스에 대한 외부 액세스를 관리한다. Ingress는 
Load Balancing, SSL Termincation 및 name-based vertual hosting을 제공 할 수 있다.

![Exposing services using an Ingress](kubernetes/Exposing%20services%20using%20an%20Ingress.PNG)



Ingress는 인바운드 연결이 클러스터 서비스에 도달하도록 허용하는 규칙 모음이다. 외부에서 연결할 수있는 URL, 트래픽에 대한 부하 분산, terminate SSL,  이름 기반의 가상 호스팅 등의 서비스를 제공하도록 Configuration 할 수 있다. 사용자는 Ingress 리소스를 API server에 포스팅하여 Ingress를 요청한다. Ingress Controller는 일반적으로 Load Balance와 함께 Ingress를 만족할 책임이 있지만, HA 방식으로 트래픽을 처리하는 데 도움이 되는 에지 라우터 또는 부가적인 프런트 엔드로 구성될 수 있다. 

Api Gateway를 Kubernetes로 가져 오겠다.



###### Step 1 : 이전 ApiGateway 마이크로서비스 삭제



Eureka와 Config Server에서 했던 것처럼 ApiGateway 마이크로서비스도 완전히 삭제한다. Kubernetes는 이미 API Gateway 패턴 구현에 사용할 수있는 Ingress 리소스를 제공한다.



###### Step 2 : ApiGateway Ingress 생성



Ingress는 3 가지 마이크로서비스를 가리킨다.

- ProductService
- OrderService
- CustomerService

Ingress를 위한 도메인 이름이 필요한다. 이미 myboutique.io 도메인 이름이 있다고 가정 해 보겠다.

Ingress descriptor는 다음과 같다.

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: api-gateway
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  backend:
    serviceName: default-http-backend
    servicePort: 80
  rules:
  - host: myboutique.io
    http:
      paths:
      - path: /product
        backend:
          serviceName: product-service
          servicePort: 8080
      - path: /order
        backend:
          serviceName: order-service
          servicePort: 8080
      - path: /customer
        backend:
          serviceName: customer-service
          servicePort: 8080
```

위 내용을 api-gateway-ingress.yml에 저장하고 리소스를 생성하기 위하여 다음을 수행한다.

```shell
kubectl create -f api-gateway-ingress.yml
```

이제 Ingress가 성공적으로 생성되었다.



##### 9.5.2.7 Distributed Tracing



이 절에서는 이전에 가지고 있던 독립형 Zipkin 인스턴스를 Kubernetes 클러스터 및 이전 localhost : 9411 대신 Kubernetes에서 호스팅된 Zipkin으로 마이크로서비스 Point를 만들기 위해 Configuration을 업데이트한다.



###### Step 1 : Kubernetes에 Zipkin 배포



Zipkin 용 공식 Docker 이미지가 있다. Kubernetes에 배포 할 이미지는 openzipkin/zipkin이다.



```shell
kubectl create deployment zipkin --image=openzipkin/zipkin
```



그런 다음 Deployment를 만든 후 Zipkin 호스트 이름으로 사용할 서비스를 사용하여 노출해야 한다.



```shell
kubectl expose deployment zipkin --type=LoadBalancer --port 9411
```



이제 zipkin이라는 호스트 이름으로 전달되는 모든 Request는 가용한 Zipkin Pod로 부하분산될 것이다.



###### Step 2 : Sleth Trace를 Zipkin으로 전달



```yaml
spring:
  application:
    name: order-service
  sleuth:
    sampler:
      probability: 1
  zipkin:
    baseUrl: http://zipkin/
...
```



spring.zipkin.baseUrl은 zipkin Kubernetes Service를 가리키고 있다.

이것이 전부다. 모든 것이 매력처럼 동작할 것이다.

