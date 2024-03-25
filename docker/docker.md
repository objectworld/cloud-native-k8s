## 8 장 컨테이너 시작하기



### 8.1 컨테이너화 개요



지금까지 개발된 쇼핑몰 애플리케이션은 물리적 전용서버 또는 가상 머신의 런타임 환경에 WAR 또는 JAR 파일로 배포된다.

소프트웨어 애플리케이션에서 발생하는 주요 위험은 애플리케이션이 중단 될 수있는 런타임 업데이트이다. 예를 들어 OS 업데이트에는  라이브러리를 포함하여 호환되지 않는 업데이트로 실행중인 애플리케이션에 영향을 미칠 수 있는 많은 업데이트가 포함될 수 있다.

일반적으로 동일한 호스트 내에는 애플리케이션과 함께 동작하는 다른 소프트웨어(데이터베이스, 프록시 등)들이 있다. 그들은 모두 동일한 운영체계와 라이브러리를 공유하고 있다. 따라서 업데이트로 인해 애플리케이션에 직접 충돌이 발생하지 않는다 하더라도 다른 서비스와의 충돌이 발생할 수 있다.

이러한 업데이트는 위험하지만, 업데이트 개선을 통해 제공된 버그 수정 또는 보안 및 안정성 문제 등에 대한 필요 때문에 수행할 수 밖에 없는 경우가 많다. 업데이트로 인하여 문제가 발생하는지 여부를 확인하기 위해 애플리케이션 및 그 환경에 대한 테스트를 수행해야 한다. 특히 대규모 애플리케이션의 경우 이는 매우 큰 작업이다. 

하지막 해결방법이 있으므로 슬퍼할 필요가 없다. 단일 운영 체제 내부에서 독립적 파티션이라고 할 수 있는 컨테이너를 사용할 수 있다. 가상 머신과 동일한 보안, 스토리지 및 네트워크 격리와 같은 많은 이점을 제공하면서도 훨씬 적은 하드웨어 리소스를 필요로 한다. 컨테이너는 가상머신과 달리 시스템 운영 체계를 직접 사용하기 때문에 실행 및 종료가 더 빠르다.

컨테이너화를 통해 리소스 활용도를 격리하고 추적 할 수 있다. 이 격리는 우리의 호스트 운영체계 업데이트와 관련된 많은 위험으로부터 애플리케이션을 보호한다.



![그림 8-1](docker/%EA%B7%B8%EB%A6%BC%208-1.png)

[그림 8-1] 전통적, 가상머신, 컨테이너, 쿠버네티스 배포 아키텍처



컨테이너는 개발자와 시스템 관리자 모두에게 아래와 같은 많은 이점을 제공한다.

- 일관된 환경(Consistent Environment)
  컨테이너를 통해 개발자는 다른 애플리케이션과 격리 된 예측 가능한 환경을 만들 수 있다. 컨테이너에는 프로그래밍 언어 런타임 및 기타 소프트웨어 라이브러리의 특정 버전 등 애플리케이션에 필요한 종속 소프트웨어도 포함될 수 있다. 개발자의 관점에서 보면, 이 모든 것은 애플리케이션이 최종적으로 배포되는 곳이 어디든 일관성이 보장된다. 이러한 모든 것이 생산성으로 이어지며, 개발자와 IT 운영팀이 환경의 차이를 디버깅하고 진단하는 데 걸리는 시간, 더 나아가 사용자에게 새로운 기능을 전달하는 시간 비용을 줄이게 된다. 개발자가 개발 및 테스트 환경이 확실히 그대로 프로덕션에 적용된다는 가정을 할 수 있기 때문에 버그가 적다는 것을 의미한다.

- 어디서든지 실행(Run Anywhere)
  컨테이너는 리눅스, 윈도우즈 및 맥 운영 체제 가상 머신 또는 베어 메탈, 개발자의 머신 또는 온 프레미스 데이터 센터, 퍼블릭 클라이드 등 거의 모든 곳에서 가상으로 실행할 수 있으므로 개발 및 배포가 크게 쉬워진다.소프트웨어를 실행하기 원하는 어디든지 컨테이너를 사용할 수 있다.

- 격리(Isolation)
  컨테이너는 OS 수준에서 CPU, 메모리, 스토리지 및 네트워크 리소스를 가상화하여 개발자들에게 다른 애플리케이션로부터 논리적으로 격리 된 OS의 샌드 박스로 제공된다.



마지막으로 컨테이너는 다중 시스템 환경의 복잡성이 없는 상용 또는 개발 환경으로 배포 할 수있는 서비스를 만들고 실행할 수 있도록 가볍고 안정적인 환경을 제공하기 때문에 마이크로서비스 개발 접근 방식을 강화한다.

사용 가능한 많은 컨테이너 형식이 있다. 도커는 널리 사용되는 오픈 소스 컨테이너 형식이다.



### 8.2 도커(Docker) 개요



#### 8.2.1 도커란?



도커는 개발자와 시스템 관리자가 애플리케이션을 컨테이너로 개발, 배포 및 실행할 수있는 플랫폼이다. 리눅스 컨테이너를 사용하여 애플리케이션을 배포하는 것을 컨테이너화(Containerization)라고한다.

컨테이너화는 다음과 같은 이유로 점점 인기를 얻고 있다.

- 유연성(Flexible) : 가장 복잡한 애플리케이션도 컨테이너화할 수 있다.
- 경량화(Lightweight) : 컨테이너가 호스트 커널을 활용하고 공유한다.
- 상호 교환가능성(Interchangeable) : 업데이트 및 업그레이드를 즉시 배포 할 수 있다.
- 이식성(Portable) : 로컬에서 빌드하고 클라우드에 배포하고 어디서나 실행할 수 있다.
- 확장성(Scalable) : 컨테이너 복제본을 늘리고 자동으로 배포 할 수 있다.
- 스택화(Stackable) : 서비스를 즉석으로 수직 스택화할 수 있다.



#### 8.2.2 이미지와 컨테이너



컨테이너는 [그림 8-2]와 같이 애플리케이션을 `docker build`를 통하여 이미지로 만들고, 'docker run'을 통하여 컨테이터로 기동된다.

![그림 8-2](docker/%EA%B7%B8%EB%A6%BC%208-2.png)

[그림 8-2] 도커 빌드와 이미지, 컨테이너의 관계



컨테이너는 이미지를 실행함으로 인하여 시작된다. 이미지는 애플리케이션을 실행하는 데 필요한 모든 것(코드, 런타임, 라이브러리, 환경 변수 및 구성(Configuration) 파일)을 포함하는 실행 가능 패키지이다.

컨테이너는 실행될 때 메모리로 로딩되는 이미지의 런타임 인스턴스, 즉 상태가있는 이미지 또는 사용자 프로세스다. 실행되는 컨테이너 목록을 조회하기 위하여 `docker ps` 명령어를 사용할 수 있다.



### 8.3 도커 아키텍처



도커는 클라이언트서버 아키텍처를 사용한다. 도커 클라이언트는 도커 컨테이너를 빌드 및 실행, 배포하는 무거운 작업을 수행하는 도커 데몬과 통신한다. 도커 클라이언트와 데몬은 동일한 시스템에서 실행되거나 도커 클라이언트를 원격 도커 데몬에 연결할 수 있다. 도커 클라이언트와 데몬은 UNIX 소켓 또는 네트워크 인터페이스를 거쳐 REST API를 사용하여 통신한다.



![그림 8-5](docker/%EA%B7%B8%EB%A6%BC%208-5.png)

[그림 8-5] 도커 아키텍처



#### 8.3.1 도커 데몬



도커 데몬(dockerd)은 도커 API 요청을 수신하고 이미지, 컨테이너, 네트워크 및 볼륨과 같은 도커 객체를 관리한다. 데몬은 또한 도커 서비스를 관리하기 위하여 다른 데몬과 통신한다.



#### 8.3.2 도커 클라이언트



도커 클라이언트 (docker)는 많은 도커 사용자가 도커와 상호 작용하는 기본 방법이다. `docker run`과 같은 명령을 사용할 때 클라이언트는 이러한 명령을 도커 데몬으로 전송하여 처리한다. 도커 명령은 도커 API를 사용한다. 도커 클라이언트는 하나 이상의 데몬과 통신한다.



#### 8.3.3 도커 레지스트리



도커 레지스트리는 도커 이미지를 저장한다. 도커 허브 및 도커 클라우드는 누구나 사용할 수 있는 공용 레지스트리이며, 도커는 기본적으로 도커 허브에서 이미지를 찾도록 구성되어 있다. 도커 레지스트리로 자신의 개인 레지스트리를 이용할 수도 있다. 

`docker pull` 또는 `docker run` 명령을 사용하여 구성된 레지스트리로부터 필요한 이미지를 가져온다. `docker push` 명령을 사용하여 이미지를 구성된 레지스트리에 푸시한다.



#### 8.3.4 도커 객체



도커를 사용하면 이미지, 컨테이너, 네트워크, 볼륨, 플러그인 및 기타 개체를 생성하게 된다. 이 절은 이러한 객체 중 일부에 대하여 간략하게 설명한다.



##### 8.3.4.1 이미지



이미지는 도커 컨테이너를 생성하기 위한 설명(Instruction)이 있는 읽기 전용 템플릿이다. 대부분의 이미지는 다른 이미지를 기반으로 몇 가지 커스터마이징을 추가하여 만들어진다. 예를 들어, 우분투 이미지를 기반으로 하는 이미지를 빌드하면서 애플리케이션을 실행하는 데 필요한 구성 세부 정보 뿐 만 아니라 아파치 웹 서버와 애플리케이션을 설치한다.

자신만의 이미지를 만들거나 다른 사람이 만들고 레지스트리에 게시한 이미지를 사용할 수도 있다. 자체 이미지를 빌드하려면 이미지를 만들고 실행하는 데 필요한 단계를 정의하는 간단한 구문으로 도커파일(Dockerfile)을 만든다.  도커파일의 각 명령어는 이미지에서 계층(Layer)를 생성한다. 도커파일을 변경하고 이미지를 다시 빌드 할 때 변경된 계층만 다시 빌드된다. 이것은 다른 가상화 기술과 비교했을 때 이미지를 매우 가벼우면서 작고 빠르게 만드는 이유 중 하나이다.



##### 8.3.4.2 컨테이너



컨테이너는 이미지의 실행 가능한 인스턴스이다. 도커 API 또는 명령줄 인터페이스(CLI)를 사용하여 컨테이너를 생성, 시작, 중지, 이동 또는 삭제할 수 있다. 컨테이너를 하나 이상의 네트워크에 연결하고, 스토리지를 붙이거나, 현재 상태를 기반으로 새 이미지를 만들 수도 있다.

기본적으로 컨테이너는 다른 컨테이너 및 호스트 시스템과 비교적 잘 격리되어 있다. 컨테이너의 네트워크, 스토리지 또는 기타 기본 하위 시스템이 다른 컨테이너 또는 호스트 시스템과 얼마나 격리되어야 하는지 제어 할 수 있다.

컨테이너는 생성하거나 시작할 때 제공하는 구성 옵션과 이미지로 정의된다. 컨테이너가 제거되면 영구 저장소에 저장되지 않은 상태 변경 사항은 사라진다.



#### 8.3.5 도커 머신



도커 머신은 윈도우즈에서 가상화 기술이 적용되지 않았을 때 사용하던 방법이다. 도커 머신은 VIrtual Box나 Parallels와 같은 솔루션으로 가상 머신을 만들고 도커용 리눅스 이미지를 설치한다. 이 이미지가 도커 호스트가 되어 도커 머신이 도커 컨테이너를 관리하게 된다. 

도커 머신은 도커 엔진이 장착된 호스트를 프로비저닝하고 관리하기 위한 툴이다. 일반적으로 로컬 시스템에 도커 머신을 설치한다. 도커 머신은 자체 명령줄 클라이언트 `docker-machine`, 도커 엔진 클라이언트 `docker` 를 둘 다 포함하고 있다. 도커 시스템을 사용하여 하나 이상의 가상 시스템에 도커 엔진을 설치할 수 있다. 이러한 가상 시스템은 로컬화되거나 (맥 또는 윈도우즈에서 시스템을 사용하여 도커 엔진을 설치하고 실행할 때) 또는 원격(시스템을 사용하여 클라우드 제공자에 도커 데몬이 설치된 호스트를 프로비저닝할 때)일 수 있다. 

도커 머신은 가상 호스트에 도커 엔진을 설치하고 `docker-machine` 명령을 사용하는 호스트를 관리하기 위한 도구이다. 도커 머신을 사용하여 로컬 맥 또는 윈도우즈, 회사 네트워크, 데이터센터, 그리고 Azure, AWS, GCP 등의 클라우드 제공자에 도커 호스트를 생성할 수 있다.

`docker-machine` 명령어를 사용하여 관리 호스트를 시작, 검사, 중지 및 다시 시작할 수 있으며, 도커 클라이언트 및 데몬을 업그레이드하고 호스트와 통신하도록 도커 클라이언트를 구성할 수 있다.

실행중인 관리 호스트의 도커머신 CLI를 지정하여 해당 호스트에 도커 명령을 직접 실행할 수 있다. 예를 들어 docker-machine env default를 실행하여 default라는 호스트를 지정하고, 화면의 지시에 따라 환경 설정을 완료한 다음에 docker ps, docker run 등의 명령을 해당 호스트에 있는 도커머신에 전송할 수 있다.



> 도커 머신은 도커 v1.12 이전의 맥 또는 윈도우즈에서 도커를 실행하는 유일한 방법이었다. 베타 프로그램 및 도커 v1.12을 시작하면서, 맥 또는 윈도우즈 용 도커는 네이티브 앱으로 사용할 수 있게 되었으며 도커 머신은 2021년 9월 27에 도커 데스크탑으로 대체되었다. 



#### 8.3.6 도커 데스크탑



도커 데스크탑은 네이티브 애플리케이션으로 만들어진 도커이다. 따라서 도커 머신이 별도 필요하지 않으며 하이퍼바이저를 이용하여 별도의 가상머신을 관리하지 않는다. 

도커 데스크탑은 WSL 2 백엔드와 하이퍼-V 백엔드 및 윈도우즈 컨테이너를 이용하는 두 가지 방법이 있다.



##### 8.3.6.1 WSL 2 백엔드



WSL 2는 마이크로소프트 사에서 개발한 Windows Subsystem for Linux Version 2를 의미하는 것으로, 도커 데스크탑을 실행하기 위해서는 다음과 같은 조건이 필요하다. 



- 윈도우 11 64비트 홈/프로/엔터프라이즈/교육용 버전 21H2 이상
- 윈도우 10 64비트 홈/프로/엔터프라이즈/교육용 버전 21H2 이상
- 윈도우내 WSL 2 기능 활성화
- 윈도우 10 또는 11에서 WSL 2이 정상적으로 동작하기 위한 조건
  -  [Second Level Address Translation (SLAT)](https://en.wikipedia.org/wiki/Second_Level_Address_Translation)을 지원하는 64비트 프로세서
  -  4GB 시스템 램 이상
  -  바이오스 세팅에서 바이오스 레벨 하드웨어 가상화 지원이 활성화되어 있어야 함



##### 8.3.6.2 하이퍼-V 백엔드 및 윈도우즈 컨테이너



- 윈도우 11 64비트 홈/프로/엔터프라이즈/교육용 버전 21H2 이상
- 윈도우 10 64비트 홈/프로/엔터프라이즈/교육용 버전 21H2 이상

* 하이퍼-V와 윈도우즈 컨테이너 기능 활성화

* 윈도우 10 또는 11에서 윈도우 10에서 클라이언트 Hyper-V가 정상적으로 동작하기 위한 조건

  -  [Second Level Address Translation (SLAT)](https://en.wikipedia.org/wiki/Second_Level_Address_Translation)을 지원하는 64비트 프로세서

  -  4GB 시스템 램 이상

  -  바이오스 세팅에서 바이오스 레벨 하드웨어 가상화 지원이 활성화되어 있어야 함



### 8.4 도커 설치 및 첫 체험



물론 윈도우 컨테이너를 이용하여 도커를 사용할 수도 있지만 이 장에서는 클라우드에서 사용하는 리눅스와 동일한 환경을 유지하기 위하여 WSL 2를 사용하고자 한다.



#### 8.4.1 WSL 2 설치



WSL 2를 설치하기에 앞서 우선 WSL 2가 설치되어 있는지 확인한다.

윈도우 커맨드 창에서 wsl 명령으로 설치여부를 확인 할 수 있다.



```bat
> wsl -l -v
  NAME                   STATE           VERSION
* Ubuntu                 Running         2
  docker-desktop-data    Stopped         2
  docker-desktop         Stopped         2
```



설치되어 있지 않다면 아래와 같이 설치한다.



```powershell
$ wsl --install -d Ubuntu
    
# 설치는 약 10분 정도 소요됨
# 윈도우 재기동 시도
# 재기동 되는 과정에서 윈도우 업데이트가 수행됨

# WSL 설치가 마무리되는 시점에 사용자 계정의 입력필요
# 사용자 계정 및 암호 생성
user: xxxx
pass: xxxx
```

​    

만약 WSL 버전이 1로 설치되어 있다면 아래를 참조하여 WSL 2로 업데이트를 수행한다. 

```powershell
$ wsl --install

$ wsl --set-version Ubuntu 2

# 기본값으로 설정 변경해도 됨
$ wsl --set-default-version 2

# 강제 재기동
$ wsl -t Ubuntu
```



WSL가 설치되었다면 아래와 같이 커맨드 창에서 WSL을 실행한다. 

- 커맨드 창에서 `wsl` 명령을 입력하면 바로 default linux 가 실행된다.
- `wsl --update`를 이용하여 최신 버전으로 업데이트를 수행할 수 있다.
- `wsl -u root` 명령으로 root 로 실행 할 수 있다.



![그림 8-6](docker/%EA%B7%B8%EB%A6%BC%208-6.png)

[그림 8-6] WSL 2 실행

 

#### 8.4.2 도커 데스트탑 설치



도커를 사용하려면 도커를 설치해야한다. 손쉬운 사용을 위하여 도커 클라이언트와 데몬이 포함된 도커 데스크탑을 사용할 것이다. 도커 데스크탑은 https://www.docker.com/products/docker-desktop/에서 플랫폼과 호환 가능한 버전을 얻을 수 있다.



![그림 8-3](docker/%EA%B7%B8%EB%A6%BC%208-3.png)

[그림 8-3] 도커 데스크탑 다운로드 화면



도커가 유료화되면서 개인 개발자, 교육, 오픈 소스 커뮤니티에서만 무상으로 사용할 수 있다.



![그림 8-4](docker/%EA%B7%B8%EB%A6%BC%208-4.png)

[그림 8-4] 도커 라이선스 정책



도커의 설치는 매우 쉽고 튜토리얼이 필요하지 않다. 

설치 후 도커가 설치되어 있는지 확인하기 위해 예를 들어 `docker version` 명령을 실행하여 설치된 버전을 조회할 수 있다.



```shell
$ docker version
Client: Docker Engine - Community               // 1
 Cloud integration: v1.0.35-desktop+001
 Version:           24.0.5
 API version:       1.43
 Go version:        go1.20.6
 Git commit:        ced0996
 Built:             Fri Jul 21 20:35:45 2023
 OS/Arch:           linux/amd64
 Context:           default

Server: Docker Desktop                          // 2
 Engine:
  Version:          24.0.5
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.6
  Git commit:       a61e2b4
  Built:            Fri Jul 21 20:35:45 2023
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.6.21
  GitCommit:        3dce8eb055cbb6872793272b4f20ed16117344f8
 runc:
  Version:          1.1.7
  GitCommit:        v1.1.7-0-g860f061
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```



1. 도커 클라이언트는 많은 도커 사용자가 도커와 상호 작용하는 기본 방법이다. 사용자가 명령을 실행하면 클라이언트는 이 명령을 수행하기 위하여 도커 데몬으로 명령 및 빌드가 필요한 스트림을 전송한다. 도커 명령은 도커 API를 사용한다. 도커 클라이언트는 둘 이상의 도커 데몬과 통신 할 수 있다.
2. 도커 데몬은 도커 API 요청을 수신하고 도커 객체를 관리한다. 데몬은 다른 데몬과 통신하여 도커 서비스를 관리할 수도 있다.



도커는 클라이언트서버 아키텍처를 사용한다. 도커 클라이언트는 도커 컨테이너를 빌드 및 실행, 배포하는 무거운 작업을 수행하기 위하여 도커 데몬(dockerd)과 통신한다. 도커 클라이언트와 데몬은 동일한 시스템에서 실행되거나 원격 도커 데몬에 대한 도커 클라이언트에 연결할 수 있다. 도커 클라이언트와 데몬은 REST API를 사용하여 유닉스 소켓 또는 네트워크 인터페이스를 거쳐 통신한다.



#### 8.4.3 도커 샘플 컨테이너 실행



도커가 정상적으로 설치되었는지 또한 도커의 동작원리를 이해하기 위하여 hello-world 이미지를 실행해보자.



```shell
$ docker run hello-world

Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
719385e32844: Pull complete
Digest: sha256:dcba6daec718f547568c562956fa47e1b03673dd010fe6ee58ca806767031d1c
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```



이 메시지를 생성하기 위해 도커는 다음 단계를 수행했다.

1. 도커 클라이언트가 도커 데몬에 연결

2. 도커 데몬은 도커 허브에서 "hello-world" 이미지를 풀링
3. 도커 데몬은 "Hello from Docker!" 메시지 출력을 생성하는 실행 파일을 실행하는 이미지를 이용하여 새 컨테이너를 생성
4. 도커 데몬은 화면 출력을 도커 클라이언트로 스트리밍하여 터미널에 전송



> 도커 허브(Docker Hub) 란?
> 도커 허브는 코드 저장소에 연결하여 할 수있는 이미지를 빌드하고 테스트하고 수동으로 푸시 한 이미지를 저장하여 호스트에 이미지를 배포하기 위한 클라우드 기반 레지스트리 서비스이다. 이는 컨테이너 이미지 검색, 배포 및 변경 관리, 사용자 및 팀 협업, 그리고 개발 파이프라인 전반에 걸친 워크플로우 자동화에 대한 중앙 집중형 자원을 제공한다.
>
> 도커 허브는 다음과 같은 주요 기능을 제공한다.
>
> - 이미지 저장소(Image Repository) : 커뮤니티 및 공식 라이브러리로부터 이미지를 검색하여 풀링하고, 
>   접근할 수 있는 내부 이미지 라이브러리를 관리 및 푸시/풀링한다.
> - 빌드 자동화(Automated Builds) : 소스코드 저장소 변경시 새 이미지를 자동으로 생성한다.
> - 웹훅(Webhooks) : 빌드 자동화의 기능으로, 저장소에 대한 성공적인 푸시 이후 웹훅을 트리거할 수 있다. 
> - 조직화(Organizations) : 작업 그룹을 만들어 이미지 저장소에 대한 액세스를 관리한다.
> - 깃허브(GitHub)와 비트버킷(Bitbucket)간 통합(Integration) : 깃허브와 비트버킷과 연계하여 도커 이미지의 빌드 자동화 워크플로우를 제공한다.



도커 이미지를 컨테이너로 구동시키기 위한 `docker run` 명령어의 형식 및 주요 옵션은 [표 9-1]과 같다.



```sh
docker run [옵션] 이미지 [명령어] [아규먼트...]
# 예시 : 우분트 이미지를 컨테이너로 구동하고 해당 컨테이너에 'ls -l' 명령어를 실행. 명령어가 끝나면 컨테이너 자동 삭제
docker run --rm ubuntu ls -l
```



[표 9-1] docker run 명령어 주요 옵션

| 옵션                   | 설명                                                         |
| ---------------------- | ------------------------------------------------------------ |
| -i <br />--interactive | 컨테이너의 표준 입력(stdin)을 활성화(주로 -it 함께 사용)     |
| -t <br />--tty         | tty(가상 터미널)을 할당 <br />리눅스에 키보드를 통해 표준 입력(stdin)을 전달할 수 있게 한다(주로 -it 함께 사용) |
| --name                 | 컨테이너 이름을 지정                                         |
| -d <br />--detach      | 컨테이너를 백그라운드로 실행                                 |
| --rm                   | docker run 명령어가 끝나면, 컨테이너 자동 삭제               |
| -p <br />--publish     | 호스트와 컨테이너의 포트를 연결 (포트포워딩) <br />-p <호스트 포트>:<컨테이너 포트> <br />ex) -p 80:8888 - 호스트에 8888로 접속하면, 컨테이너 내부의 80포트로 자동 접속 |
| -v <br />--volume      | 호스트와 컨테이너의 디렉토리 연결(마운트) <br />-v <호스트 절대경로>:<컨테이너 절대경로> <br />ex) -v /Users:/usr. - 컨테이너 /usr에 저장하는 파일은 호스트의 /Users 디렉토리에 저장 |
| --restart              | 컨테이너 종료시, 재시작 정책 설정 <br />--restart="always" : 항상 재시작 <br />--restart="on-failure" : 종료 스테이터스가 0이 아닐 때 재시작 <br />* --rm 옵션과 --restart 옵션은 동시에 사용할 수 없음 |
| --privileged           | 컨테이너 안에서 호스트의 리눅스 커널 기능을 모두 사용        |

 

기존 로컬 도커 이미지 리스트를 조회하려면 다음 명령어를 사용한다.



```shell
$ docker image ls
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    9c7a54a9a43c   3 months ago   13.3kB
```



> Image ID는 이미지를 식별하기 위해 무작위로 생성된 16진수 값이다.



모든 도커 컨테이너 리스트를 조회하려면 다음 명령어를 사용한다.



```shell
docker container ls --all

CONTAINER ID<1> IMAGE 		COMMAND  CREATED 		 STATUS 				  PORTS	NAMES<2>
54f4984ed6a8 	hello-world "/hello" 20 seconds ago  Exited (0) 9 seconds ago       suzyland
```



1. CONTAINER ID는 컨테이너를 식별하기 위해 임의로 생성된 16진수 값이다.
2. 여기에서 얻은 컨테이너 이름은 별도 지정하지 않는 한 도커 데몬이 임의로 생성한 문자열 이름이다.



### 8.5 도커에 자바 애플리케이션 배포하기



이미 도커 허브에 등록된 애플리케이션 만으로 도커를 이해하기에는 부족하다. 간단한 스프링 부트 애플리케이션을 개발하여 도커 컨테이너에 배포해보자.

이 절에서는 다음과 같은 과정을 통하여 도커를 이해할 것이다.

* 자바를 이용한 스프링 부트 애플리케이션 개발
* 도커파일로 컨테이너를 정의
* 도커를 이용하여 애플리케이션을 컨테이너에 배포
* 원격 저장소를 통한 컨테이너 배포
* 도커 이미지 빌드 과정을 자동화



#### 8.5.1 샘플 애플리케이션 생성



우선  "Hello ObjectWorld!"를 리턴하는 간단한 REST API를 스프링 부트 애플리케이션을 구현해 보자. 

과거에는 자바 애플리케이션을  개발하기 시작할 때, 첫 번째 순서는 시스템에 자바 런타임을 설치하는 것이다. 그러나 애플리케이션이 기대하는대로 실행되기 위해서는 시스템 환경을 완벽하도록 만들어야 하며, 또한 상용 환경과 일치해야 한다. 
도커를 사용하면 설치할 필요없이 이식 가능한 자바 런타임을 이미지로 가져올 수 있다. 그런 다음 빌드에는 기본 자바 이미지에 개발한 애플리케이션, 관련된 구성, 런타임 등을 모두 함께  포함시킬 수 있다.

이러한 이식 가능한 이미지는 도커파일(Dockerfile)이라는 항목으로 정의된다.

Spring Initializr(https : //start.spring.io/)를 사용하여 새로운 docker-hello 스프링 부트 애플리케이션을 만들기 위하여 다음의 dependency 추가가 필요하다.

- Web
- Actuator



![그림 8-7](docker/%EA%B7%B8%EB%A6%BC%208-7.png)

[그림 8-7] 도커 샘플 애플리케이션의 생성



다음으로 메인 클래스에 "Hello ObjectWorld!"를 출력하는 RestController를 생성한다. 여러 컨테이너에서 실행될 수 있기 때문에 컨테이너의 IP 주소를 출력하도록 하였다.



```java
@RestController
@SpringBootApplication
public class HelloApplication {
	static String ipAddress = null;
    
	public static void main(String[] args) {
		SpringApplication.run(HelloApplication.class, args);
		InetAddress ip;
		try {
			ip = InetAddress.getLocalHost();
			ipAddress = ip.getHostAddress();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/hello")
	public String hello() throws UnknownHostException {
		return "Hello ObjectWorld! I'm " + ipAddress + ".\n";
	}
}
```



`mvn clean install`을 사용하여 이 애플리케이션을 컴파일하면 JAR 파일을 target 폴더에서 사용할 수 있다. target 폴더에서 아래와 같이 실행한 뒤 정상적으로 실행되는지 확인하자.



```bat
> java -jar HelloApplication-0.0.1-SNAPSHOT.jar
...
2023-08-15T23:46:10.343+09:00  INFO 14260 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2023-08-15T23:46:10.399+09:00  INFO 14260 --- [           main] o.o.docker.hello.HelloApplication        : Started HelloApplication in 5.526 seconds (process running for 7.721)
```



애플리케이션 기동이 완료된 다음에  http://localhost:8080/hello를 호출하면 [그림 8-8]과 같은 결과를 확인할 수 있다.



![그림 8-8](docker/%EA%B7%B8%EB%A6%BC%208-8.png)

[그림 8-8] 로컬에서 실행한 REST API 호출 결과 



#### 8.5.2 도커파일로 컨테이너 정의 및 이미지 빌드



도커파일은 컨테이너 내부 환경에서 진행되는 작업을 정의한다. 네트워킹 인터페이스 및 디스크 드라이브와 같은 리소스에 대한 액세스는 이 환경 내에서 가상화되며, 시스템의 나머지 부분과 격리(Isolated)되므로 포트를 외부 세계에 매핑하고 해당 환경에 "복사"하고 싶은 파일들을 지정한다. 이 작업 이후 도커파일에 정의 된 앱의 빌드는 실행되는 곳마다 정확히 동일하게 동작한다.



빈 디렉터리를 만들어서 새 디렉터리로 이동(cd)하고 Dockerfile이라는 이름의 파일을 만어서 아래 내용을 해당 파일에 복사하여 붙여넣고 저장한다. 새 도커파일의 각 문을 설명하는 주석을 참고하기 바란다.



```dockerfile
# Use an OpenJDK Runtime as a parent image
FROM eclipse-temurin:17-jdk

# Add Maintainer Info
LABEL maintainer="yuskim@gmail.com"

# Define environment variables
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
	JAVA_OPTS=""

# Set the working directory to /app
WORKDIR /app

# Copy the executable into the container at /app
ADD target/*.jar app.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run app.jar when the container launches
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
```



이 도커파일은 아직 생성하지 않은 app.jar을 참조한다. 이 파일은 샘플 애플리케이션의 실행 가능한 JAR 파일이다.



다음으로 JAR 파일과 동일한 폴더에 Dockerfile을 생성한다. ADD 명령로 JAR 파일에 액세스 할 수 있게 해야 한다.
다. WSL 2로 로그인한 뒤 target 폴더로 이동하여 `ls -p | grep -v` 명령을 실행하면 현재 폴더에 있는 파일들만 보일 것이다.

```shell
$ cd /mnt/d/dev/msa/docker/chapter08.01-docker-hello/target

$ ls -p | grep -v /
HelloApplication-0.0.1-SNAPSHOT.jar
HelloApplication-0.0.1-SNAPSHOT.jar.original
```



이제 Dockerfile과 jar 파일이 준비되었으므로 도커 이미지를 빌드해야 한다. 프로젝트 루트 폴더로 이동하여 빌드 명령을 실행해보자. 의미 있는 이름을 이름을 가지도록 -t를 사용하여 docker-hello로 태그를 지정하였으며 이 명령을 통하여 도커 이미지가 생성되었다.



```shell
$ docker build -t docker-hello .
[+] Building 45.8s (8/8) FINISHED                                                           docker:default
 => [internal] load build definition from Dockerfile                                                  0.3s
 => => transferring dockerfile: 600B                                                                  0.1s
 => [internal] load .dockerignore                                                                     0.3s
 => => transferring context: 2B                                                                       0.0s
 => [internal] load metadata for docker.io/library/eclipse-temurin:17-jdk                             3.5s
 => [1/3] FROM docker.io/library/eclipse-temurin:17-jdk@sha256:9b0a0bb921daabc6187974bdb97223e25845  39.0s
 => => resolve docker.io/library/eclipse-temurin:17-jdk@sha256:9b0a0bb921daabc6187974bdb97223e258454  0.1s
 => => sha256:9b0a0bb921daabc6187974bdb97223e258454a956b854023a9107af2096a31b6 1.70kB / 1.70kB        0.0s
 => => sha256:e94f2d910995ef47f476717df3ccd7493ead7a5515d49a487f32c8904e2b3801 1.37kB / 1.37kB        0.0s
 => => sha256:8abd7ed44e30f7a66a7a649b2206cf2ea33cd65ed698d74544099f5af9d5e559 6.71kB / 6.71kB        0.0s
 => => sha256:1ccd2d5dafe8ee2e15a3fbe193041c068fdadeda1797014f93048fa9a300e06e 17.46MB / 17.46MB      5.2s
 => => sha256:75b660a991dbdb4ec05fe96ad3d45ec613d0da0bf922edd4180768db9e121675 175B / 175B            1.1s
 => => sha256:79d73bf9539bed37e681f3e5594ae1f62399c98ab172bf339561a685fe92b2a0 144.78MB / 144.78MB   32.8s
 => => sha256:ab3262e9d6b3aab0326b651a5b37c850bee90d9fb2b4b3262166daa5e8ab4d34 666B / 666B            1.7s
 => => extracting sha256:1ccd2d5dafe8ee2e15a3fbe193041c068fdadeda1797014f93048fa9a300e06e             6.4s
 => => extracting sha256:79d73bf9539bed37e681f3e5594ae1f62399c98ab172bf339561a685fe92b2a0             5.0s
 => => extracting sha256:75b660a991dbdb4ec05fe96ad3d45ec613d0da0bf922edd4180768db9e121675             0.0s
 => => extracting sha256:ab3262e9d6b3aab0326b651a5b37c850bee90d9fb2b4b3262166daa5e8ab4d34             0.0s
 => [internal] load build context                                                                     3.4s
 => => transferring context: 21.44MB                                                                  3.3s
 => [2/3] WORKDIR /app                                                                                2.1s
 => [3/3] ADD target/*.jar app.jar                                                                    0.3s
 => exporting to image                                                                                0.3s
 => => exporting layers                                                                               0.2s
 => => writing image sha256:4a7768b1482c9cb17ac824937b4d1461e9645aa1d94dfaece29cf0c977e66697          0.0s
 => => naming to docker.io/library/docker-hello                                                       0.0s

What's Next?
  View summary of image vulnerabilities and recommendations → docker scout quickview
```

1. 도커가 eclipse-temurin:17-jdk 이미지를 로컬에서 찾지 못해 도커 허브에서 다운로드한다.
2. 도커파일의 모든 명령어는 지정된 단계에서 빌드된다. 그리고 그것은 이미지의 각 계층으로 분리된다. 각 단계의 끝에 표시된 16진수 코드는 계층에 대한 ID이다.
3. 빌드 된 이미지는 docker-hello:latest로 태그가 지정된다. 이름(docker-hello)만 지정했지만 Docker는 자동으로 lastest version 태그를 추가한다.



구축 된 이미지는 어디에 있는가? 컴퓨터의 로컬 Docker 이미지 레지스트리에 있다.



```shell
$ docker image ls
REPOSITORY     TAG       IMAGE ID       CREATED         SIZE
docker-hello   latest    4a7768b1482c   6 minutes ago   428MB
hello-world    latest    9c7a54a9a43c   3 months ago    13.3kB
```



로컬에 두 개의 이미지가 있음을 알 수 있다. hello-world는 8.4 절에서 풀링한 이미지이고, docker-hello는 지금 만든 이미지이다.



#### 8.5.3 도커 컨테이너로 애플리케이션 실행



앱을 실행하고 -p 옵션을 사용하여 머신의 포트 28080을 컨테이너의 게시된 포트 8080에 매핑한다.

```shell
$ docker run -p 28080:8080 docker-hello

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.1.2)

2023-08-14T12:58:57.227Z  INFO 1 --- [           main] o.o.d.HelloApplication.HelloApplication  : Starting HelloApplication v0.0.1-SNAPSHOT using Java 17.0.8 with PID 1 (/app/app.jar started by root in /app)
2023-08-14T12:58:57.237Z  INFO 1 --- [           main] o.o.d.HelloApplication.HelloApplication  : No active profile set, falling back to 1 default profile: "default"
2023-08-14T12:59:00.492Z  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)
2023-08-14T12:59:00.529Z  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2023-08-14T12:59:00.530Z  INFO 1 --- [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.11]
2023-08-14T12:59:00.745Z  INFO 1 --- [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2023-08-14T12:59:00.755Z  INFO 1 --- [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 3323 ms
2023-08-14T12:59:02.019Z  INFO 1 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 1 endpoint(s) beneath base path '/actuator'
2023-08-14T12:59:02.180Z  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2023-08-14T12:59:02.215Z  INFO 1 --- [           main] o.o.d.HelloApplication.HelloApplication  : Started HelloApplication in 6.11 seconds (process running for 7.531)
```



스프링 부트 애플리케이션이 정상적으로 시작되었다는 "Started HelloApplication in 6.11 seconds (process running for 7.531)" 로그가 표시되어야 한다. "Tomcat started on port(s): 8080 (http) with context path ''"과 같은 메시지가 표시되었지만 그 메시지는 컨테이너 내부에서 표시된 것으로 컨테이너 포트 8080를 28080으로 매핑 한 것을 알지 못한다. 컨테이너 외부에서 접근하기 위한 올바른 URL은 http://localhost:28080이다. 웹 브라우저에서 http://localhost:28080/hello를 조회하면 [그림 8-9]와 같이 RestController의 응답을 확인할 수 있다.



![그림 8-9](docker/%EA%B7%B8%EB%A6%BC%208-9.png)

[그림 8-9] 컨테이너로 실행된 REST API 호출 결과 



WSL을 하나 더 실행한 뒤 쉘에서 curl 명령을 사용하여 동일한 콘텐츠를 확인할 수도 있다.



```shell
curl http://localhost:28080/hello
Hello ObjectWorld!
```



> cURL이란?
> cURL은 다양한 프로토콜을 사용하여 데이터를 전송하는 라이브러리 및 명령 줄 도구를 제공하는 컴퓨터 소프트웨어 프로젝트이다. cURL 프로젝트는 libcurl과 cURL, 두 가지 상품을 공개하였다. 1997 년에 처음 릴리즈되었다. 이름은 "클라이언트 URL"을 의미한다.
>
> libcurl은 cookie, DICT, FTP, FTPS, Gopher, HTTP (HTTP / 2 지원 포함), HTTP POST, HTTP PUT, HTTP 프록시
> 터널링, HTTPS, IMAP, Kerberos, LDAP, POP3, RTSP, SCP 및 SMTP를 지원하는 무료 클라이언트 측 URL 전송 라이브러리이다. 라이브러리는 file URI scheme, SFTP, Telnet, TFTP, file transfer resume, FTP uploading,
> HTTP form-based upload, HTTPS certificate, LDAPS, 프록시 및 사용자와 비밀번호 인증을 지원한다.
>
> cURL은 URL 구문을 사용하여 파일을 가져오거나 전송하기 위한 명령 줄 도구이다. cURL은 libcurl을 사용하기 때문에 현재 HTTP, HTTPS, FTP, FTPS, SCP, SFTP, TFTP, LDAP, DAP, DICT, TELNET, FILE, IMAP, POP3, SMTP 및 RTSP을 포함한 다양한 일반 인터넷 프로토콜을 지원한다.



28080 : 8080의 포트 재매핑은 도커파일 내부에서 노출 되는 것과  `docker run -p`를 실행할 때 게시되는 값이 설정되는 항목간의 차이점을 보여준다. 이후 단계에서는 호스트의 포트 28080을 컨테이너의 포트 8080에 매핑하고 http://localhost를 사용한다.



Docker 이미지를 실행한 WSL 2 콘솔 터미널에서 CTRL + C를 눌러 종료한다.



> 윈도우에서 컨테이너를 명시 적으로 중지하기
>
> 윈도우 시스템에서 CTRL + C는 컨테이너를 중지하지 않는다. 따라서 먼저 CTRL + C를 입력하여
> 프롬프트를 다시 가져 오거나 다른 Shell을 연 다음 docker container ls를 입력하여 실행 중인 컨테이너 목록을 조회한 다음에 docker container stop <컨테이너 이름 또는 ID>를 통해서 컨테이너를 중지한다. 그렇지 않으면 다음 단계에서 컨테이너를 다시 실행하려고 할 때 데몬에서 오류 응답을 받는다.



이제 -d 또는 --detach 옵션을 선택하여 백그라운드에서 앱을 실행 해 보자.



```shell
$ docker run -d -p 28080:8080 docker-hello
5868ccd369e9c9d4e76e04ad820e7c19877027490a44368b690d8ae851e8f3bb
```



여기서 앱의 긴 컨테이너 ID를 얻은 다음 터미널로 돌아간다. 컨테이너가 백그라운드에서 실행 중이다. 축약 된 컨테이너 ID를 docker container ls (명령이 실행될 때 두 작업을 바꿔서 수행할 수도 있다)를 통해서 조회할 수도 있다. 



```shell
$ docker container ls
CONTAINER ID IMAGE        COMMAND                CREATED        STATUS        PORTS                   NAMES
5868ccd369e9 docker-hello "/entrypoint.sh java…" 46 seconds ago Up 45 seconds 0.0.0.0:28080->8080/tcp com...
```



컨테이너 ID는 http://localhost:28080의 내용과 일치한다. 이제 다음과 같이 CONTAINER ID를 사용하여 docker container stop으로 프로세스를 종료한다.

```shell
$ docker stop 5868ccd369e9
5868ccd369e9
```



정상적으로 종료되었다면 컨테이너 ID가 출력된다. 만약 잘못된 컨테이너 ID라면 아래와 같이 출력된다.



```shell
$ docker stop 5868ccd369e2
Error response from daemon: No such container: 5868ccd369e2
```



종료된 컨테이너 ID로 `docker stop` 명령어를 실행한다고 해도 정상적인 종료 명령어와 같은 결과가 출력되므로 `docker ps`를 통하여 컨테이너 정상적으로 종료되었는지 확인하기 바란다.



#### 8.5.4 원격 레지스트리를 통한 컨테이너 배포



8.5.2절에서 빌드한 이미지의 이식성을 확인하기 위해 빌드된 이미지를 업로드하고 다른 곳에서 실행하겠다. 추후 상용환경에 컨테이너를 배포하려는 경우 레지스트리에 푸시하는 방법을 알아야한다.

레지스트리는 저장소 모음이고 저장소는 코드가 이미 빌드 된 경우를 제외하고 GitHub 저장소와 같은 이미지 모음이다. 레지스트리의 한 계정으로 많은 저장소를 생성할 수 있다. Docker CLI는 기본적으로 Docker의 공용 레지스트리를 사용한다.



> Docker의 공용 레지스트리는 무료이고 사전 구성되어 있기 때문에 여기에서 사용하지만 선택할 수있는 많은 공개된 저장소가 있으며 Docker Trusted Registry를 사용하여 자신의 개인 레지스트리를 설정할 수도 있다.



##### 8.5.4.1 도커 ID로 로그인



도커 계정이없는 경우 https://hub.docker.com/에서 가입하면 된다. 사용자명을 메모해 둔다. 

로컬 머신의 도커 공용 레지스트리에 로그인한다.



```shell
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: objectworld
Password:
Login Succeeded

Logging in with your password grants your terminal complete access to your account.
For better security, log in with a limited-privilege personal access token. Learn more at https://docs.docker.com/go/access-tokens/
```



##### 8.5.4.2 이미지에 태그 지정



로컬 이미지를 레지스트리의 저장소와 연결하는 표기법은 username/repository:tag 다. 태그는 선택 사항이지만 레지스트리에서 도커 이미지에 버전을 제공하는데 사용하는 메커니즘이므로 지정하는 것을 권장한다. 컨텍스트에 대해 get-started : part2와 같이 의미있는 이름과 저장소 및 태그를 지정한다. 그러면 이미지가 get-started 저장소에 저장되고 part2로 태그가 지정된다.

이제 이미지에 태그를 지정하기 위해 표기법을 이용하여 태깅한다. 이미지가 원하는 목적지에 업로드되도록 사용자명, 저장소, 그리고 태그를 가지고 도커 태그 이미지를 실행한다. 그 명령의 문법은 다음과 같다.



```shell
$ docker tag image username/repository:tag
```



8.5.2절에서 빌드한 이미지를 아래와 같이 태깅하자.



```shell
$ docker tag docker-hello objectworld/docker-hello:v1
```



`docker image ls` 명령을 실행하여 새로 태그가 지정된 이미지를 확인해보면 다음과 같다.



```shell
$ docker image ls
REPOSITORY                 TAG       IMAGE ID       CREATED          SIZE
docker-hello               latest    738f664933d6   46 minutes ago   428MB
objectworld/docker-hello   v1        738f664933d6   46 minutes ago   428MB
ubuntu                     latest    5a81c4b8502e   6 weeks ago      77.8MB
hello-world                latest    9c7a54a9a43c   3 months ago     13.3kBㅇ
```



##### 8.5.4.3 이미지 게시



`docker push` 명령어를 통하여 태그가 지정된 이미지를 저장소에 업로드한다.



```shell
$ docker push username/repository:tag
```



한 번 도커 레지스트리에 등록이 완료되면 이 업로드의 결과를 공개적으로 사용할 수 있다. 도커 허브에 로그인하면  `docker pull` 명령으로 새 이미지를 확인할 수 있다.



> 이미지를 푸시하기 전에 docker login 명령을 사용하여 인증을 받아야한다.



아래와 같이 objectworld/docker-hello:v1 태그된 이미지를 푸시할 것이다.



```shell
$ docker push objectworld/docker-hello:v1
The push refers to repository [docker.io/objectworld/docker-hello]
1a89a79fa018: Pushed
3c89a4a5ff9b: Pushed
fa62bb8b13b2: Pushed
2d4fb665621f: Pushed
f90999372b70: Pushed
981db337ecdc: Pushed
59c56aee1fb4: Pushed
v1: digest: sha256:3844461d85307ebb343afc08fc288b417dd532643603beee8a0cc2d2e4444ebd size: 1786
```



##### 8.5.4.4 원격 레지스트리에서 이미지 가져 오기 및 실행



이제부터 다음 명령을 사용하여 도커 허브 접속이 가능한 모든 컴퓨터에서 `docker run`을 사용하고 앱을 실행할 수 있다.



```shell
docker run -d -p 28080:8080 username/repository:tag
```



이미지를 머신에서 로컬로 사용할 수없는 경우 도커는 저장소에서 이미지를 가져온다. 이미지를 로컬에서 삭제하고 원격에서 이미지를 가져와 보자.



```shell
$ docker image rm objectworld/docker-hello:v1
Untagged: objectworld/docker-hello:v1
Untagged: objectworld/docker-hello@sha256:3844461d85307ebb343afc08fc288b417dd532643603beee8a0cc2d2e4444ebd

$ docker image ls
REPOSITORY     TAG       IMAGE ID       CREATED             SIZE
docker-hello   latest    738f664933d6   About an hour ago   428MB
ubuntu         latest    5a81c4b8502e   6 weeks ago         77.8MB
hello-world    latest    9c7a54a9a43c   3 months ago        13.3kB

$ docker run -p 28080:8080:v1
Unable to find image 'objectworld/docker-hello:v1' locally
v1: Pulling from objectworld/docker-hello
Digest: sha256:3844461d85307ebb343afc08fc288b417dd532643603beee8a0cc2d2e4444ebd
Status: Downloaded newer image for objectworld/docker-hello:v1

...
```



도커 실행이 실행되는 위치에 관계없이 이미지에 필요한 모든 계층과 함께 이미지를 가져와서 코드를 실행한다. 이 모든 것이 깔끔한 작은 패키지로 함께 이동하며, 이를 실행하기 위하여 도커만 구성되어 있다면 호스트 머신에 아무것도 설치할 필요가 없다.



#### 8.5.5 도커 이미지 빌드 자동화



개발 과정에서 애플리케이션은 여러 번 수정되고 빌드된다. 메이븐이 통합된 IDE(Eclipse, NetBeans, IntelliJ 등)는 단 한번의 클릭이나 자동으로 빌드를 수행할 수 있다.

도커 이미지도 업데이트되어야 하지만 수동으로 다시 빌드 할 경우 복잡할 수 있으며, 따라서 애플리케이션이 업데이트될 때마다 도커 컨테이너에서 애플리케이션을 테스트해야하는 경우 그것도 번거로운 작업이 된다.

다행히도 메이븐을 사용하여 이 프로세스를 자동화 할 수 있는 많은 플러그인이 있다. 최근에 도커가 유료화되면서 도커가 아닌 OCI를 지원하는 Jib를 많이 사용하는 추세다.



##### 8.5.4.1 스포티파이 도커파일 메이븐 플러그인



스포티파이에는 메이븐과 도커를 원활하게 통합하는 데 도움이 되는 dockerfile-maven-plugin이라는 메이븐 플러그인이 있다.

dockerfile-maven-plugin은 도커파일이 프로젝트 루트 폴더에 있어야 한다.

이를 사용하려면 pom.xml 파일에서 build 섹션의 plugin에 이 플러그인을 추가해야한다.



```xml
<plugin>
	<groupId>com.spotify</groupId>
	<artifactId>dockerfile-maven-plugin</artifactId>
	<version>1.4.13</version>
	<executions>
        <!-- 1 -->
		<execution>
			<id>package</id>
			<goals>
				<goal>build</goal>
				<goal>push</goal>
			</goals>
		</execution>
	</executions>
	<configuration>
        <!-- 2 -->
		<repository>objectworld/${project.artifactId}</repository>
        <!-- 3 -->
		<tag>${project.version}</tag>
        <!-- 4 -->
		<buildArgs>
			<JAR_FILE>${project.build.finalName}.jar</JAR_FILE>
		</buildArgs>
	</configuration>
</plugin>
```

1. 메이븐 빌드 라이프 사이클의 install 단계에 <executions> 태그를 사용하여 `dockerfile : build goal`을 등록했다. 따라서 `mvn install`을 실행할 때마다 `dockerfile-maven-plugin`의 `build` goal이 실행되고 도커 이미지가 빌드된다. 여기에 빌드 된 이미지를 도커 허브로 푸시하기 위한 `push` goal 같이 다른 goal을 추가 할 수 있다.
2. 빌드된 도커 이미지 저장소 및 이미지 이름
3. 빌드된 도커 이미지 태그
4. 도커파일에서 사용할 매개변수 JAR_FILE 전달



> 스포티파이의 dockerfile-maven-plugin
>
> dockerfile-maven-plugin은 도커 이미지를 지정된 도커 레지스트리에 푸시하기 위하여  /.dockercfg 또는 /.docker/config.json 구성 파일에 저장된 인증 정보를 사용한다. 이러한 구성 파일은 도커 로그인을 통해 도커에 로그인할 때 생성된다. 
>
> 메이븐 settings.xml 또는 pom.xml 파일에 인증 세부 정보를 지정할 수도 있다.



기존 도커 파일을 사용해도 되겠지만 JAR_FILE이란 매개변수를 사용하도록 수정하였다. 이제 도커파일도 매개변수를 이용하여 아래와 같이 수정한다.

 

```dockerfile
# Use an OpenJDK Runtime as a parent image
FROM eclipse-temurin:17-jdk

# Add Maintainer Info
LABEL maintainer="yuskim@gmail.com"

# Define environment variables
ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS \
	JAVA_OPTS=""

# Set the working directory to /app
WORKDIR /app

# Copy the executable into the container at /app
ARG JAR_FILE
ADD target/${JAR_FILE} app.jar

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run app.jar when the container launches
CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
```



이제 `mvn install`을 수행하면 아래와 같은 메시지와 함께 도커 이미지 빌드까지 처리된다. 왜인지는 모르겠지만 이미지를 빌드하기 전에 잠시 멈춤 현상이 발생된다.



```
[INFO] --- dockerfile-maven-plugin:1.4.13:build (package) @ docker-hello ---
[INFO] dockerfile: null
[INFO] contextDirectory: D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile
[INFO] Building Docker context D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile
[INFO] Path(dockerfile): null
[INFO] Path(contextDirectory): D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile
[INFO] 
[INFO] Image will be built as objectworld/docker-hello:0.0.1-SNAPSHOT
[INFO] 
[INFO] Step 1/8 : FROM eclipse-temurin:17-jdk
[INFO] 
[INFO] Pulling from library/eclipse-temurin
[INFO] Image 9d19ee268e0d: Already exists
[INFO] Image 1ccd2d5dafe8: Already exists
[INFO] Image 79d73bf9539b: Already exists
[INFO] Image 75b660a991db: Already exists
[INFO] Image 594307c077a3: Pulling fs layer
[INFO] Image 594307c077a3: Downloading
[INFO] Image 594307c077a3: Download complete
[INFO] Image 594307c077a3: Extracting
[INFO] Image 594307c077a3: Pull complete
[INFO] Digest: sha256:4dd9ed6e2e9853228c01107b0353966c8898044644c81c71ede8be9770b4284f
[INFO] Status: Downloaded newer image for eclipse-temurin:17-jdk
[INFO]  ---> a1521a1e7ef1
[INFO] Step 2/8 : LABEL maintainer="yuskim@gmail.com"
[INFO] 
[INFO]  ---> Running in bf4538bb9b56
[INFO] Removing intermediate container bf4538bb9b56
[INFO]  ---> de01eacd8d50
[INFO] Step 3/8 : ENV SPRING_OUTPUT_ANSI_ENABLED=ALWAYS 	JAVA_OPTS=""
[INFO] 
[INFO]  ---> Running in a23f7688be78
[INFO] Removing intermediate container a23f7688be78
[INFO]  ---> 5337722028a5
[INFO] Step 4/8 : WORKDIR /app
[INFO] 
[INFO]  ---> Running in 987c2409ccbf
[INFO] Removing intermediate container 987c2409ccbf
[INFO]  ---> 5d0f54c2ddea
[INFO] Step 5/8 : ARG JAR_FILE
[INFO] 
[INFO]  ---> Running in 2e1fe22aba78
[INFO] Removing intermediate container 2e1fe22aba78
[INFO]  ---> a8513cd569b1
[INFO] Step 6/8 : ADD target/${JAR_FILE} app.jar
[INFO] 
[INFO]  ---> 9c044b955d81
[INFO] Step 7/8 : EXPOSE 8080
[INFO] 
[INFO]  ---> Running in dc9f8106c186
[INFO] Removing intermediate container dc9f8106c186
[INFO]  ---> 6fccfc4cbb98
[INFO] Step 8/8 : CMD ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app/app.jar"]
[INFO] 
[INFO]  ---> Running in 7b913e661463
[INFO] Removing intermediate container 7b913e661463
[INFO]  ---> 9903c5090272
[INFO] Successfully built 9903c5090272
[INFO] Successfully tagged objectworld/docker-hello:0.0.1-SNAPSHOT
[INFO] 
[INFO] Detected build of image with id 9903c5090272
[INFO] Building jar: D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile\target\docker-hello-0.0.1-SNAPSHOT-docker-info.jar
[INFO] Successfully built objectworld/docker-hello:0.0.1-SNAPSHOT
[INFO] 
[INFO] --- maven-install-plugin:3.1.1:install (default-install) @ docker-hello ---
[INFO] Installing D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile\pom.xml to C:\Users\Youth\.m2\repository\org\objectworld\docker\docker-hello\0.0.1-SNAPSHOT\docker-hello-0.0.1-SNAPSHOT.pom
[INFO] Installing D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile\target\docker-hello-0.0.1-SNAPSHOT.jar to C:\Users\Youth\.m2\repository\org\objectworld\docker\docker-hello\0.0.1-SNAPSHOT\docker-hello-0.0.1-SNAPSHOT.jar
[INFO] Installing D:\dev\msa\docker\chapter08.02-docker-hello-spotify-dockerfile\target\docker-hello-0.0.1-SNAPSHOT-docker-info.jar to C:\Users\Youth\.m2\repository\org\objectworld\docker\docker-hello\0.0.1-SNAPSHOT\docker-hello-0.0.1-SNAPSHOT-docker-info.jar
```



도커 이미지를 확인하면 다음과 같이 신규로 도커 이미지가 등록되었음을 확인할 수 있다.



```sh
$ docker image ls
REPOSITORY                 TAG              IMAGE ID       CREATED              SIZE
objectworld/docker-hello   0.0.1-SNAPSHOT   9903c5090272   About a minute ago   428MB
eclipse-temurin            17-jdk           a1521a1e7ef1   13 hours ago         407MB
docker-hello               latest           738f664933d6   18 hours ago         428MB
objectworld/docker-hello   v1               738f664933d6   18 hours ago         428MB
ubuntu                     latest           5a81c4b8502e   6 weeks ago          77.8MB
hello-world                latest           9c7a54a9a43c   3 months ago         13.3kB
```



물론 도커를 이용하여 컨테이너로 기동시킬 수 있다.



```sh
$ docker run -d -p 28080:8080 objectworld/docker-hello:0.0.1-SNAPSHOT
d07c932fe3850873511eead7263e92a08f4d903bfcd49e9af78e185f0f3dcf6a

$ docker ps
CONTAINER ID   IMAGE                                     COMMAND                  
CREATED         STATUS         PORTS                     NAMES
d07c932fe385   objectworld/docker-hello:0.0.1-SNAPSHOT   "/__cacert_entrypoin…"   
7 seconds ago   Up 6 seconds   0.0.0.0:28080->8080/tcp   great_bardeen
```



도커 데스크탑을 통하여 그 상태를 확인해 볼 수 있다.



![그림 8-10](docker/%EA%B7%B8%EB%A6%BC%208-10.png)

[그림 8-10] 도커 데스크탑을 통한 컨테이너 이미지 확인



##### 8.5.4.2 패브릭8 도커 메이븐 플러그인



패브릭8 도커 메이븐 플러그인은 도커파일 없이 컨테이너 이미지를 생성할 수 있다. 다음과 같이 pom.xml에 패브릭8 도커 메이븐 플러그인을 설정한다.



```xml
<plugin>
	<!-- To run: mvn docker:build -->
	<groupId>io.fabric8</groupId>
	<artifactId>docker-maven-plugin</artifactId>
	<version>0.43.3</version>
	<configuration>
		<images>
			<image>
				<name>objectworld/${project.name}:${project.version}</name>
				<build>
					<from>eclipse-temurin:17-jdk</from>
					<maintainer>yuskim@gmail.com</maintainer>
					<assembly>
						<descriptorRef>artifact</descriptorRef>
					</assembly>
					<ports>
						<port>8080</port>
					</ports>
					<cmd>java -Djava.security.egd=file:/dev/./urandom -jar maven/${project.build.finalName}.jar</cmd>
				</build>
				<run>
					<ports>
						<port>28080:8080</port>
					</ports>
				</run>
			</image>
		</images>
	</configuration>
	<!-- Adding this part always executes the docker:build during Maven's 
		package phase. No need to execute above mentioned command. -->
	<executions>
		<execution>
			<id>docker:build</id>
			<phase>package</phase>
			<goals>
				<goal>build</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```



테스트를 위하여 pom.xml에서 프로젝트의 버전을 0.0.2-SNAPSHOT으로 수정하여 `mvn install`로 빌드해보자. 빌드 마지막 부분에 아래와 같이 도커 이미지가 생성되는 것을 확인할 수 있다.



```
[INFO] --- docker-maven-plugin:0.43.3:build (docker:build) @ docker-hello ---
[INFO] Copying files to D:\dev\msa\docker\chapter08.03-docker-hello-fabric8-docker\target\docker\objectworld\docker-hello\0.0.2-SNAPSHOT\build\maven
[INFO] Building tar: D:\dev\msa\docker\chapter08.03-docker-hello-fabric8-docker\target\docker\objectworld\docker-hello\0.0.2-SNAPSHOT\tmp\docker-build.tar
[INFO] DOCKER> [objectworld/docker-hello:0.0.2-SNAPSHOT]: Created docker-build.tar in 3 seconds 
[INFO] DOCKER> [objectworld/docker-hello:0.0.2-SNAPSHOT]: Built image sha256:7f4fa
```



도커 이미지를 확인하면 다음과 같이 신규로 도커 이미지가 등록되었음을 확인할 수 있다.



```sh
$ docker image ls
REPOSITORY                 TAG              IMAGE ID       CREATED          SIZE
objectworld/docker-hello   0.0.2-SNAPSHOT   7f4fa933e742   14 minutes ago   428MB
objectworld/docker-hello   0.0.1-SNAPSHOT   97a60876910c   17 minutes ago   428MB
eclipse-temurin            17-jdk           a1521a1e7ef1   14 hours ago     407MB
docker-hello               latest           738f664933d6   19 hours ago     428MB
objectworld/docker-hello   v1               738f664933d6   19 hours ago     428MB
ubuntu                     latest           5a81c4b8502e   6 weeks ago      77.8MB
hello-world                latest           9c7a54a9a43c   3 months ago     13.3kB
```



물론 도커를 이용하여 컨테이너로 기동시킬 수 있다.



```sh
$ docker run -d -p 28080:8080 objectworld/docker-hello:0.0.2-SNAPSHOT
6991b495dc36259686d3cd88b44611b0a01fdf2f7618ea70256dbb5771bf271c

$ docker ps
CONTAINER ID   IMAGE                                     COMMAND                  
CREATED         STATUS         PORTS                     NAMES
6991b495dc36   objectworld/docker-hello:0.0.2-SNAPSHOT   "/__cacert_entrypoin…"   
8 seconds ago   Up 6 seconds   0.0.0.0:28080->8080/tcp   zen_ride
```

 

##### 8.5.4.3 구글 Jib 메이븐 플러그인



Jib는 구글의 자바 애플리케이션용 도커 및 OCI 이미지를 빌드하기위한 메이븐 플러그인으로 가장 많이 사용되는 플러그인이다.

Jib는 컨테이너 이미지에 애플리케이션을 패키징하기 위한 모든 단계를 처리하는 빠르고 간단한 컨테이너 이미지 빌더이다. 도커파일을 작성하거나 도커를 설치할 필요가 없으며, 빌드에 플러그인을 추가하는 것 만으로 메이븐에 직접 통합되어 자바 애플리케이션을 즉시 컨테이너화할 수 있다. 



![그림 8-11](docker/%EA%B7%B8%EB%A6%BC%208-11.png)

[그럼 8-11] 일반적인 도커 빌드 프로세스와 Jib를 이용한 빌드 프로세스의 비교



Jib은 메이븐 및 그래들 용 플러그인으로 제공되며 최소한의 구성이 필요하다. 간단히 빌드 정의에 플러그인을 추가하고 대상 이미지를 구성하면 된다. Jib는 또한 필요한 경우 도커 데몬에 이미지를 빌드하는 추가적인 규칙을 제공한다.



> 개인 레지스트리에 빌드하는 경우에는 레지스트리에 대한 자격증명으로  Jib을 구성해야 한다. Jib는 또한 GCR(Google Container Registry), ECR(Amazon Elastic Container Registry), 도커 허브 레지스트리, JCR(JFrog Container Registry), ACR(Azure Container Registry) 등 다양한 레지스트리에 저장할 수 있다.
>
> 자세한 내용은 공식 Jib 문서(https://github.com/GoogleContainerTools/jib/tree/master/jib-maven-plugin#authentication-methods)에서 살펴보기 바란다.



Jib를 사용하려면 pom.xml 파일에있는 빌드 섹션의 플러그인에 플러그인을 추가해야한다.



```xml
<plugin>
	<groupId>com.google.cloud.tools</groupId>
	<artifactId>jib-maven-plugin</artifactId>
	<version>3.3.2</version>
	<configuration>
		<from>
			<image>eclipse-temurin:17-jdk</image>
		</from>
		<to>
			<image>objectworld/${project.artifactId}</image>
			<tags>
				<tag>${project.version}</tag>
				<tag>latest</tag>
			</tags>
		</to>
	</configuration>
	<executions>
		<execution>
			<phase>package</phase>
			<goals>
				<goal>dockerBuild</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```



<image> 태그는 저장소 이름, 이미지 이름 및 이미지 태그를 지정한다.  아래와 같은 이미지 레지스트리를 이미지 이름의 접두사로 지정할수 있다.

- gcr.io
- aws_account_id.dkr.ecr.region.amazonaws.com
- registry.hub.docker.com



비공개 레지스트리에서 푸시 / 풀링하려면 인증 자격 증명이 필요한다. 이는 Docker 자격 증명 도우미를 사용하거나 Maven 설정에 정의하여 처리할 수 있다. 자격 증명을 명시적으로 정의하지 않으면, Jib은 Docker Config에 정의 된 자격 증명을 사용하거나 공통 자격 증명 도우미로 판단한다.

테스트를 위하여 pom.xml에서 프로젝트의 버전을 0.0.3-SNAPSHOT으로 수정하여 `mvn install`로 빌드해보자. 빌드 마지막 부분에 아래와 같이 도커 이미지가 생성되는 것을 확인할 수 있다.



```
[INFO] --- jib-maven-plugin:3.3.2:dockerBuild (default) @ docker-hello ---
[WARNING] 'mainClass' configured in 'maven-jar-plugin' is not a valid Java class: ${start-class}
[INFO] 
[INFO] Containerizing application to Docker daemon as objectworld/docker-hello, objectworld/docker-hello:0.0.3-SNAPSHOT, objectworld/docker-hello...
[WARNING] Base image 'eclipse-temurin:17-jdk' does not use a specific image digest - build may not be reproducible
[INFO] Getting manifest for base image eclipse-temurin:17-jdk...
[INFO] Building dependencies layer...
[INFO] Building resources layer...
[INFO] Building classes layer...
[INFO] Building jvm arg files layer...
[INFO] The base image requires auth. Trying again for eclipse-temurin:17-jdk...
[WARNING] The credential helper (docker-credential-desktop) has nothing for server URL: registry-1.docker.io

Got output:

credentials not found in native keychain

[WARNING] The credential helper (docker-credential-desktop) has nothing for server URL: registry.hub.docker.com

Got output:

credentials not found in native keychain

[INFO] Using credentials from Docker config (C:\Users\Youth\.docker\config.json) for eclipse-temurin:17-jdk
[INFO] Using base image with digest: sha256:4dd9ed6e2e9853228c01107b0353966c8898044644c81c71ede8be9770b4284f
[INFO] 
[INFO] Container entrypoint set to [java, -cp, @/app/jib-classpath-file, org.objectworld.docker.hello.HelloApplication]
[INFO] Loading to Docker daemon...
[INFO] 
[INFO] Built image to Docker daemon as objectworld/docker-hello, objectworld/docker-hello:0.0.3-SNAPSHOT, objectworld/docker-hello
```



도커 이미지를 확인하면 다음과 같이 신규로 도커 이미지가 등록되었음을 확인할 수 있다.



```sh
$ docker image ls
REPOSITORY                 TAG              IMAGE ID       CREATED          SIZE
objectworld/docker-hello   0.0.2-SNAPSHOT   7f4fa933e742   55 minutes ago   428MB
objectworld/docker-hello   0.0.1-SNAPSHOT   97a60876910c   57 minutes ago   428MB
eclipse-temurin            17-jdk           a1521a1e7ef1   15 hours ago     407MB
objectworld/docker-hello   v1               738f664933d6   20 hours ago     428MB
ubuntu                     latest           5a81c4b8502e   6 weeks ago      77.8MB
hello-world                latest           9c7a54a9a43c   3 months ago     13.3kB
objectworld/docker-hello   0.0.3-SNAPSHOT   968b31dbc540   53 years ago     428MB
objectworld/docker-hello   latest           968b31dbc540   53 years ago     428MB
```



이상하게 생성된 날짜가 53년전으로 설정되어 있다. 이는 Jib에서 재생력(Reproducibility) 목적으로 이미지의 생성날짜를 Unix 최초 시간(UTC 1970년 1월 1일 0시 0분 0초)으로 설정하였기 때문이다. 자세한 내용은 https://github.com/GoogleContainerTools/jib/blob/master/docs/faq.md#why-is-my-image-created-48-years-ago를 참고하기 바란다.

이는 물론 도커를 이용하여 컨테이너로 기동시킬 수 있다. 이제 0.0.3-SNAPSHOT 뿐 만 아니라 latest 태그로도 등록하였으므로 latest로 컨테이너를 기동하면 된다.



```sh
$ docker run -d -p 28080:8080 objectworld/docker-hello:latest
f63bcb20967246c7d4d8f1580a8bf4b769f46d8af13bc2d2a4f93eae3ccb1b9d

$ docker ps
CONTAINER ID   IMAGE                             COMMAND                  
CREATED         STATUS         PORTS                     NAMES
f63bcb209672   objectworld/docker-hello:latest   "java -cp @/app/jib-…"   
6 seconds ago   Up 4 seconds   0.0.0.0:28080->8080/tcp   naughty_nash
```

 

#### 8.5.5 도커 서비스 만나기



도커만으로는 애플리케이션을 컨테이너화하기엔 부족하다. 만약 애플리케이션을 두 개의 컨테이너로 기동시키려면, 네트워크 포트 문제가 발생한다. 즉, 아래와 같이 서로 다른 포트로 애플리케이션을 구동시켜야 하고 애플리케이션들의 로드 밸런싱을 수행하기 위한 L4 스워치가 필요하게 된다.



```sh
$ docker run -d --name userlist2 -p 28080:8080 objectworld/docker-hello:latest
$ docker run -d --name userlist2 -p 28081:8080 objectworld/docker-hello:latest
```



이러한 구성은 매우 번거로운 작업이기 때문에, 도커를 통하여 다수의 애플리케이션을 구성하는 방법으로 도커 컴포즈(Docker Compose)와 도커 스웜(Docker Swarm)을 사용한다. 도커 컴포즈는 다수의 서버를 제어하는 데 많은 어려움이 있으므로 이 절에서는 도커 스웜을 이용할 것이다. 

분산 애플리케이션에서 애플리케이션의 여러 조각을 "서비스"라고 한다. 예를 들어 비디오 공유 사이트를 상상해보자. 아마도 애플리케이션 데이터를 데이터베이스에 저장하는 서비스, 사용자가 무언가를 업로드 한 후 백그라운드에서 비디오 트랜스 코딩하기 위한 서비스, 프론트트 엔드 서비스 등이 있을 것이다.

서비스는 실제로 "상용 환경에 있는 컨테이너"이다. 서비스는 하나의 이미지만 실행하지만 이미지 실행 방법을 코드화한다. 설정가능한 실행 구성 정보는 다음과 같다.

* 사용할 TCP 포트
* 컨테이너 실행 시 필요한 CPU 및 메모리
* 컨테이너 오류 발생 시 재기동 정책
* 서비스가 필요한 용량을 갖도록 실행되어야 하는 컨테이너의 복제본(replica) 수 등

해당 소프트웨어의 조각을 실행하는 컨테이너 인스턴스 수를 변경하여 서비스를 확장하면, 프로세싱하는 서비스에 더 많은 컴퓨팅 리소스를 할당한다.

다행히도 도커 플랫폼으로 서비스를 정의, 실행 및 확장하는 것은 매우 쉽다. docker-compose.yml 파일만 수정하면 된다.



##### 8.5.5.1 도커 서비스 제작



도커 서비스를 제작하기 위해서는 우선 dock-compose.yml 파일을 제작하여야 한다. docker-compose.yml 파일은 상용 환경에서의 도커  컨테이너의 작동 방식을 정의하는 YAML 파일이다.

원하는 곳에이 파일을 docker-compose.yml로 저장한다. 여기는 8.5.4.3절에서 Jib로 빌드한 이미지를 사용할 것이며, YAML 파일을 이미지 세부 정보에 맞게 username/repo : tag로 업데이트한다. 



```yaml
services:
  hello_app:
    image: objectworld/docker-hello:latest
    deploy:
      replicas: 2
      resources:
        limits:
          memory: 600M
      restart_policy:
        condition: on-failure
    ports:
      - 8080
    environment:
      - SERVICE_PORTS=8080
    networks:
      - hello_net
 
  hello_proxy:
    image: dockercloud/HAProxy
    depends_on:
      - hello_app
    environment:
      - BALANCE=leastconn
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    ports:
      - 28080:80
    networks:
      - hello_net
    deploy:
      placement:
        constraints: [node.role == manager]
 
networks:
  hello_net:
    driver: overlay
```



이 docker-compose.yml 파일은 Docker에 다음을 수행하도록 알려준다.

- 첫 번째 서비스는 우리가 빌드한 애플리케이션을 기반으로 한 hello_app 서비스다.
  - 도커 레지스트리에 등록된 objectworld/docker-hello:latest 이미지를 레지스트리에서 가져온다.
  - 해당 이미지의 2 개 인스턴스를 hello_app이라는 서비스로 실행하여 각 인스턴스 당 최대 600MB RAM으로 자원을 제한한다.
  - 컨테이너가 실패하면 즉시 다시 시작한다.
  - 컨테이너 로컬 포트 8080으로 정의된다.
  - HAProxy를 위하여 SERVICE_PORTS=8080이라는 환경변수를 지정한다.
  - hello_net이라는 부하 분산 된 네트워크를 통해 포트 8080을 공유하도록 hello_app 컨테이너에 지시한다.

- 두 번째 서비스는 도커 클라우드에 있는 HAProxy 애플리케이션을 기반으로 한 hello_proxy 서비스다.
  - 도커 레지스트리에 등록된 dockercloud/HAProxy 이미지를 레지스트리에서 가져온다.
  - depends_on 옵션으로 hello_app 서비스가 부팅이 완료된 이후에 실행을 시작한다. 또한 `volumes` 옵션으로 `docker.sock` 파일을 공유하도록 설정한다. HAProxy 컨테이너가 네트워크에 이미 존재하거나 새롭게 생성되는 컨테이너들을 찾고 확인할 수 있어야 하기 때문이다.
  - HAProxy에 설정된 컨테이너 로컬 포트 80을 외부 28080 포트에 매핑한다.
  - hello_net이라는 부하 분산 된 네트워크를 통해 다른 컨테이너의 포트 8080을 공유하도록 hello_proxy 컨테이너에 지시한다.
  - deploy 설정에서 항상 manager 노드에서 실행되도록 설정하였다. 이는 도커 스웜은 여러 노드로 구성될 수 있기 때문에 고정된 노드에서 실행될 수 있도록 하기 위하여 필요하다.

- 기본 설정 (부하 분산 된 오버레이 네트워크)으로 hello_net 네트워크를 정의한다.
  - 두 서비스는 하나의 네트워크로 묶여 있는데 이것이 핵심 포인트다.




##### 8.5.5.2 새로운 부하 분산 된 앱 실행



도커 서비스를 배포하기 전에 먼저 도커 스웜 클러스터를 생성한다. 현재는 하나의 노드만으로 구성되었지만 `docker swarm join` 명령어를 통하여 여러 개의 노드를 워커로 조인할 수 있다. 

```shell
$ docker swarm init
Swarm initialized: current node (rgo5u5jcrpa7bs44fjpruwrh2) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-5j2ty8paisw68v3bpw8r6vtd87aucfm8eiaekovol33017850z-9sxfgt1dnh7rvil3wu7trco2y 192.168.65.4:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

```



`docker swarm init`를 실행하지 않으면 앞으로 실행되는 명령어는 "this node is not a swarm manager" 라는 에러와 함께 실패하게  된다.



> 도커 스웜(Docker Swarm)이란?
> 스웜은 도커를 실행하는 머신 그룹을 의미하며 클러스터로 조인된다. 스웜으로 조인하면 익숙한 도커 명령을 계속 사용하지만, 실제로는 스웜 관리자에 의하여 클러스터에서 실행된다. 스웜안의 머신은 물리적 또는 가상머신일 수 있다. 스웜에 조인하고 난 뒤에는 이들을 노드라고 부른다.
>
> 스웜은 물리적 또는 가상 머신이 포함된 여러 노드로 구성된다.
> 기본 개념은 충분히 간단하다 : docker swarm init를 실행하여 스웜 모드를 활성화하고
> 현재 컴퓨터를 스웜 관리자로 만든 다음 다른 컴퓨터에서 워커(worker)로 스웜에 조인하기 위하여 `docker swarm join`을 실행하면 된다. 여기서는 가상 머신을 사용하여 두 대의 컴퓨터 클러스터를 빠르게 만들고
> 스웜으로 바꿀 것이다. 



이제 docker-compose가 저장된 위치로 이동하여 스택을 배포한다. 스택명은 docker-hello로 지정하였다. 스택명은 docker-compose에 있는 서비스명과 결합되어 실제 서비스 인스턴스의 명칭이 된다.



```shell
$ cd /mnt/d/dev/msa/docker/chapter08.05-docker-compose/docker
$ docker stack deploy -c docker-compose.yml docker-hello
Creating network docker-hello_hello_net
Creating service docker-hello_hello_app
Creating service docker-hello_hello_proxy
```



배포된 하나의 서비스 스택은 하나의 호스트에 objectworld/docker-hello:latest 이미지를 통하여 배포된 2개의 컨테이너 인스턴스와 dockercloud/haproxy:latest 이미지를 통하여 배포된 1개의 컨테이너로 실행되었다. `docker service ls`확인하기 위하여 서비스 목록을 조회해보자.

```shell
$ docker service ls
ID             NAME                       MODE         REPLICAS   IMAGE                             PORTS
c4lhjybal2r0   docker-hello_hello_app     replicated   2/2        objectworld/docker-hello:latest   *:30006->8080/tcp
zyzmqlr4rb33   docker-hello_hello_proxy   replicated   1/1        dockercloud/haproxy:latest        *:28080->80/tcp

```



서비스명은 스택명과 docker-compose.yml에 정의된 서비스의 조합으로 명명된다. 즉 실제 실행된 서비스는 docker-hello_hello_app와 docker-hello_hello_proxy다.

서비스에서 실행되는 컨테이너 인스턴스를 태스크라고한다. 태스크에는 docker-compose.yml에서 정의한 복제본 수까지 숫자로 증가하는 고유 ID가 부여된다. 서비스에 대한 태스크 목록을 조회해 보자.



```shell
$ docker service ps docker-hello_hello_app
ID             NAME                       IMAGE                             NODE             
DESIRED STATE   CURRENT STATE            ERROR     PORTS
e3p58bo63qp4   docker-hello_hello_app.1   objectworld/docker-hello:latest   docker-desktop   
Running         Running 30 minutes ago   
49u9dmi77fcp   docker-hello_hello_app.2   objectworld/docker-hello:latest   docker-desktop   
Running         Running 30 minutes ago   
```



시스템의 모든 컨테이너 목록을 조회하는 경우에도 태스크가 표시되지만 서비스로 필터링되지는 않는다.



```shell
$ docker ps
CONTAINER ID   IMAGE                             COMMAND                  CREATED          
STATUS          PORTS                       NAMES
517dc792fefe   objectworld/docker-hello:latest   "java -cp @/app/jib-…"   35 minutes ago   
Up 35 minutes                               docker-hello_hello_app.2.49u9dmi77fcpq4jzrcgib255e
c53ae58ff22b   dockercloud/haproxy:latest        "/sbin/tini -- docke…"   35 minutes ago   
Up 35 minutes   80/tcp, 443/tcp, 1936/tcp   docker-hello_hello_proxy.1.i9fz57hi5bp4ve3szi33d9ay8
de057a088315   objectworld/docker-hello:latest   "java -cp @/app/jib-…"   35 minutes ago   
Up 35 minutes                               docker-hello_hello_app.1.e3p58bo63qp45l98v4h8w7ezc
```



##### 8.5.5.3 앱 스케일링



컨테이너를 추가하고 싶을 때, docker-compose.yml에서 replicas 값을 변경하고 변경사항을 저장한 뒤에, `docker stack deploy` 명령으로 재실행을 하면 애플리케이션을 스케일링할 수 있다. 여기서는 복제본을 3으로 설정한  docker-compose-scaling.yml을 이용하여 스케일링을 수행하도록 하겠다.

```shell
$ docker stack deploy -c docker-compose-scaling.yml docker-hello
Updating service docker-hello_hello_app (id: c4lhjybal2r0h2p2o6hbj6j49)
image objectworld/docker-hello:latest could not be accessed on a registry to record
its digest. Each node will access objectworld/docker-hello:latest independently,
possibly leading to different nodes running different
versions of the image.

Updating service docker-hello_hello_proxy (id: zyzmqlr4rb33feghennyeppgy)
```



Docker는 내부 업데이트(In-place update)를 수행하므로 먼저 스택을 분해하거나 컨테이너를 종료 할 필요가 없다. 이제 `docker service ps docker-hello_hello_app`를 다시 실행하여 배포 된 인스턴스가 재구성되었는지 확인한다. 



```sh
$ docker service ps docker-hello_hello_app
ID             NAME                       IMAGE                             NODE             DESIRED STATE   CURRENT STATE                ERROR     PORTS
e3p58bo63qp4   docker-hello_hello_app.1   objectworld/docker-hello:latest   docker-desktop   Running         Running 55 minutes ago   
49u9dmi77fcp   docker-hello_hello_app.2   objectworld/docker-hello:latest   docker-desktop   Running         Running 55 minutes ago   
5ql0uoh6zjfw   docker-hello_hello_app.3   objectworld/docker-hello:latest   docker-desktop   Running         Running about a minute ago
```



브라우저 또는 cURL을 이용하여 `http://localhost:28080/hello`를 호출하면 3개의 IP가 반환되는 것을 확인할 수 있다.

복제본에 대하여 스케일 업을 수행한 경우 더 많은 태스크, 즉 더 많은 컨테이너가 기동된다.



##### 8.5.5.4 애플리케이션과 도커 스웜 클러스터



만약 도커 서비스를 중단하고 싶을 때에는 아래와 같은 명령을 사용하여 도커 스택에서 애플리케이션을 제거한다.



```shell
$ docker stack rm docker-hello                         
Removing service docker-hello_hello_app
Removing service docker-hello_hello_proxy
Removing network docker-hello_hello_net
```



만약 도커 스웜 클러스터를 제거하고 싶을 경우에는 아래와 같은 명령어를 사용하여 도커 스웜 클러스터를 중단한다. 해당 명령어는 각 노드에서 개별로 실행되어야 한다.



```shell
$ docker swarm leave --force
Node left the swarm.
```



도커를 사용하여 애플리케이션을 컨테이너로 기동시키고 스케일링을 하는 방법을 학습하였다. 상용환경에서 이렇게 컨테이너를 사용하게 되면 마치 가상머신처럼 독립적으로 애플리케이션을 운영할 수 있다. 

다음 절에서는 쇼핑몰 애플리케이션을 도커 클러스터에서 그룹핑하여 실행하는 방법에 대하여 살펴보겠다.



### 8.6 쇼핑몰을 컨테이너로 배포하기



이 절에서는 8.5절에서 학습한 내용을 바탕으로 쇼핑몰 운영에 필요한 마이크로서비스 패턴 및 마이크로서비스들을 배포할 것이다. 우선 도커 이미지 빌드를 위해서는 8.5.4.3절에서 설명한 구글의 Jib를 이용하여 이미지를 빌드하고, 이를 바탕으로 마이크로서비스 패턴 및 쇼핑몰 애플리케이션을 컨테이너로 배포할 것이다. 

쇼핑몰 애플리케이션은 [그림 8-12]와 같이 3개의 마이크로서비스와 이를 연계하기 위한 마이크로서비스 패턴으로 구성되어 있다.



![image-20230821124233014](docker/%EA%B7%B8%EB%A6%BC%208-12-1711334496814.png)

[그림 8-12] 쇼핑몰 애플리케이션 구성도



#### 8.6.1 도커 이미지 빌드하기



이제 도커를 시작 했으므로 마이크로서비스를 컨테이터화해야 한다. 프로젝트 의존성 추가를 위하여 pom.xml에 Jib 메이븐 플러그인을 추가해야 한다.



```xml
<plugin>
	<groupId>com.google.cloud.tools</groupId>
	<artifactId>jib-maven-plugin</artifactId>
	<version>3.3.2</version>
	<configuration>
		<from>
			<image>eclipse-temurin:17-jdk</image>
		</from>
		<to>
			<image>objectworld/${project.artifactId}</image>
			<tags>
				<tag>${project.version}</tag>
				<tag>latest</tag>
			</tags>
		</to>
	</configuration>
	<executions>
		<execution>
			<phase>package</phase>
			<goals>
				<goal>dockerBuild</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```



그리고 Docker 이미지를 빌드한다.



```shell
mvn compile jib:dockerBuild
```



Docker 이미지를 빌드 한 후 Docker 이미지를 수행하면 다음을 얻을 수 있다.



```shell
REPOSITORY 						TAG 			IMAGE ID 		CREATED 		SIZE
objectworld/customer-service 	0.0.1-SNAPSHOT 	a11824661356 	5 minutes ago 	148MB
objectworld/order-service 		0.0.1-SNAPSHOT 	96d770656f1a 	5 minutes ago 	148MB
objectworld/hystrix-dashboard 	0.0.1-SNAPSHOT 	1aab18bc8798 	5 minutes ago 	125MB
objectworld/product-service 	0.0.1-SNAPSHOT 	fbc4fb89c8cd 	5 minutes ago 	147MB
objectworld/api-gateway 		0.0.1-SNAPSHOT 	73496f8bbf21 	5 minutes ago 	133MB
objectworld/config-server 		0.0.1-SNAPSHOT 	960d46621d0b 	5 minutes ago 	110MB
objectworld/discovery-server	0.0.1-SNAPSHOT 	193bba74c1bb 	5 minutes ago 	128MB
oeclipse-temurin            	17-jdk           a1521a1e7ef1   15 hours ago    407MB
openzipkin/zipkin 				latest 			639cba1daeb3 	8 days ago 		147MB
```



#### 8.6.2 도커에 마이크로서비스 패턴 컨테이너 배포하기



이제 올바른 포트로 이미지를 실행해야 한다. 



##### 8.6.2.1 Config Server



```shell
docker run --name config-server -d -p 8788:8788 objectworld/config-server:0.0.1-SNAPSHOT
```



##### 8.6.2.2 Eureka



```shell
docker run -d -p 8761:8761 objectworld/discovery-server:0.0.1-SNAPSHOT
```



이것은 작동하지 않는다. 이 구성정보는 java.net.ConnectException을 발생시킨다.



```shell
...
INFO 1 --- [Thread-13] o.s.c.n.e.server.EurekaServerBootstrap : Eureka data center value eureka.datace\
nter is not set, defaulting to default
ERROR 1 --- [nfoReplicator-0] c.n.d.s.t.d.RedirectingEurekaHttpClient : Request execution error
c.s.j.api.client.ClientHandlerException: java.net.ConnectException: Connection refused...
```



Eureka에서 발생한 Exception은 프로그램이 Config-Server에 연결할 수 없기 때문으로, 원인은 매우 간단하다.



시작시 Eureka는 application.yml의  spring.cloud.config.uri property에 정의 된 주소인 http://localhost:8788로 Config-Server를 요청한다.

컨테이너 내부에서 어떻게 진행되는지 상상해 보자. 컨테이너화 된 Eureka 애플리케이션은 전용 컨테이너에 배정되었고, 그래서 컨테이너 내부에서 http://localhost:8788 주소를 요청할 때 localhost는 Eureka 컨테이너를 가리킨다. 그러나 Config-Server 애플리케이션은 Eureka의 현재 로컬 호스트가 아닌 자체 컨테이너에서 호스팅되어 있다.

따라서 해결책은 Eureka와 다른 컨테이너를 http://localhost:8788이 아닌 Config-Server 의 Container 주소로 연결하는 것이다. 코드를 다시 작성하고 코드를 변경하지는 않을 것이므로 두려워할 필요 없다. 환경 변수를 사용하여 문제를 해결할 수 있는 스프링 부트의 뛰어난 기능이 있다.



> 스프링 부트 애플리케이션에 속성 주입
>
> 시스템 환경 변수를 사용하여 Property를 쉽게 전달 / 재정의 할 수 있다. 예를 들어 spring.cloud.config.uri Property을 전달 / 재정의하려면 SPRING_CLOUD_CONFIG_URI 환경 변수에 새 값을 할당하면 된다.
> 따라서 스프링 부트 애플리케이션이 시작되면 환경 변수를 파싱하고 환경 변수에 정의 된 Element에 우선 순위를 부여한다. 따라서 bootstrap.yml 또는 애플리케이션.properties에 정의된 값도 환경 변수에서 다른 값이 전달 된 경우 환경변수를 반영하도록 고려된다.



Docker는 컨테이너 생성시 환경 변수를 선언하는 기능을 제공한다.



```shell
docker run -e "env_var_name = env_var_value" image_name
```



> 값을 지정하지 않고 환경 변수의 이름을 지정하면 이름이 지정된 변수의 현재 값이 컨테이너의 환경으로 전파된다.



따라서 다음 명령을 사용하여 spring.cloud.config.uri 속성을 정의 할 수 있다.



```shell
docker run -d \
-e SPRING_CLOUD_CONFIG_URI=http://CONFIG-SERVER-CONTAINER-IP:8788 \
-p 8761:8761 objectworld/eureka:0.0.1-SNAPSHOT
```



다음 명령을 사용하여 CONFIG-SERVER-CONTAINER-IP의 값을 가져올 수 있다.



```shell
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' config-server 

172.17.0.2
```



따라서 실제 명령은 다음과 같다.



```shell
docker run -d \
-e SPRING_CLOUD_CONFIG_URI=http://172.17.0.2:8788 \
-p 8761:8761 objectworld/eureka:0.0.1-SNAPSHOT
```



위의 방법도 괜찮지만 그렇게 좋지는 않다. 컨테이너는 계속해서 IP가 변경되며, 우리는 매번 IP를 찾지는 않는다.이것은 무거운 작업이며 생산적이지 않다.

Docker는 Container Links와 같은 생태계의 성능과 생산성을 향상시키는 많은 훌륭한 기능을 제공한다.

Container Links는 컨테이너가 상호 통신 할 수있는 환경 변수를 생성한다. 새 컨테이너를 실행하거나 기존 것을 편집 할 때 컨테이너 링크를 명시 적으로 지정할 수 있다.

따라서 명령에서 이 Links를 사용할 수 있다.



```shell
docker run --name eureka \
	--link config-server \ <1>
	-d -e SPRING_CLOUD_CONFIG_URI=http://config-server:8788 \ <2>
	-p 8761:8761 objectworld/eureka:0.0.1-SNAPSHOT
```

1. --link config-server = config-server:를 작성하는 것과 동일하게 예를 들어 우리의 Eureka 컨테이너에서 사용할 수있는 IP 주소등과 같은 config-server 컨테이너 정보를 만든다.
2. SPRING_CLOUD_CONFIG_URI 속성은 Config Server 컨테이너 IP 주소로 확인되는 config-server라는 호스트를 가리킨다. 이것은 linking 메카니즘 통하여 가능해진다.
3. --link 플래그는 Docker의 레거시 기능이다. 이 기능은 나중에 제거 될 수 있다. 이 방법을 사용하는 것이 절대적으로 필요하지 않는다면, --link를 사용하는 대신 두 컨테이너 간의 통신을 용이하게 한기 위한 사용자 정의 네트워크를 사용하는 것을 추천한다. 하나의 기능
   사용자 정의 네트워크 기능은 --link를 사용한 Container간의 환경 변수 공유를 지원하지는 않는다. 그러나 볼륨과 같은 다른 메커니즘을 사용하여 보다 통제 된 방식으로 컨테이너 간의 환경 변수를 공유 할 수 있다.



##### 8.6.2.3 API Gateway



```shell
docker run --name api-gateway \
    --link config-server \
    -d -e SPRING_CLOUD_CONFIG_URI=http://config-server:8788 \
    -p 8222:8222 objectworld/api-gateway:0.0.1-SNAPSHOT
```



##### 8.6.2.4 Zipkin



```shell
docker run --name zipkin -d -p 9411:9411 openzipkin/zipkin
```



##### 8.6.2.5 Hystrix 대시 보드

```shell
docker run --name hystrix-dashboard \
    --link config-server \
    -d -e SPRING_CLOUD_CONFIG_URI=http://config-server:8788 \
    -p 8988:8988 objectworld/hystrix-dashboard:0.0.1-SNAPSHOT
```



#### 8.6.3 도커에 쇼핑몰 애플리케이션 컨테이너 배포하기

####  

Product-Srevice, Order-Service 및 Customer-Service의 경우 Config Server에서했던 것처럼 Zipkin 서버 컨테이너 IP 주소를 전달해야한다.



##### 8.6.3.1 Product-Srevice



```shell
docker run --name product-service \
    --link config-server \
    --link zipkin \
    -d -e SPRING_CLOUD_CONFIG_URI=http://config-server:8788 \
    -e SPRING_ZIPKIN_BASE-URL=http://zipkin:9411/ \
    -p 9990:9990 objectworld/product-service:0.0.1-SNAPSHOT
```



##### 8.6.3.2 Order-Service



```shell
docker run --name order-service \
    --link config-server \
    --link zipkin \
    -d -e SPRING_CLOUD_CONFIG_URI=http://config-server:8788 \
    -e SPRING_ZIPKIN_BASE-URL=http://zipkin:9411/ \
    -p 9991:9991 objectworld/order-service:0.0.1-SNAPSHOT
```



##### 8.6.3.3 Customer-Service



```shell
docker run --name customer-service \
    --link config-server \
    --link zipkin \
    -d -e SPRING_CLOUD_CONFIG_URI=http://config-server:8788 \
    -e SPRING_ZIPKIN_BASE-URL=http://zipkin:9411/ \
    -p 9992:9992 objectworld/customer-service:0.0.1-SNAPSHOT
```



### 8.7 정리



이번 장에서 우리는 도커를 이용하여 애플리케이션을 물리적인 서버와 독립적으로 운영하는 방법에 이점에 대하여 파악하였다.

그러나 동일한 서버 (도커 호스트)에 여러 컨테이너들을 배포하는 것은 간단하지만 여러 서버에 많은 컨테이너를 배포하는 것을 고려하기 시작할 때에는 서버 관리, 컨테이너 상태 관리 등 복잡한 상황에 직면하게 된다.

- 이들 컨테이너 중 하나가 실패하면 어떻게 되는가?
- 모니터링 프로세스가 비정상 작동하거나 컨테이너가 가용하지 않는 경우 어떻게 되는가? 
- 컨테이너가 실행되는 서버에 장애가 발생되면 어떻게 되는가?



위와 같은 비정상적인 상황에서는 서버 관리, 컨테이너 상태 관리 등의 처리 방법이 복잡해진다. 최근에는 이러한 상황을 대응하기 위해 오케스트레이션 컴퓨팅, 네트워킹 및 스토리지 인프라과 같은 많은 기능을 제공하는 오케스트레이션 시스템이 대두되고 있다. 

다음 장에서는 컨테이너 오케이스트레이션, 네트워킹, 스토리지 인프라 등과 같은 많은 기능을 제공하는 쿠버네티스 시스템에 대하여 설명하겠다.

