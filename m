From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 11/17] kokr/locking/memory-barriers: De-emphasize smp_read_barrier_depends() some more
Date: Mon, 16 Apr 2018 09:12:39 -0700
Message-ID: <1523895165-17576-11-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180416161209.GA6895@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416161209.GA6895@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, SeongJae Park <sj38.park@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

This commit applies an upstream change, commit f28f0868feb1
("locking/memory-barriers: De-emphasize smp_read_barrier_depends() some
more") to the Korean version documentation.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../translations/ko_KR/memory-barriers.txt         | 27 ++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 99ef4ca1c1bf..21e78af7ee93 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -80,7 +80,7 @@ Documentation/memory-barriers.txt
 
      - 메모리 배리어의 종류.
      - 메모리 배리어에 대해 가정해선 안될 것.
-     - 데이터 의존성 배리어.
+     - 데이터 의존성 배리어 (역사적).
      - 컨트롤 의존성.
      - SMP 배리어 짝맞추기.
      - 메모리 배리어 시퀀스의 예.
@@ -576,8 +576,14 @@ ACQUIRE 는 해당 오퍼레이션의 로드 부분에만 적용되고 RELEASE 
 	    Documentation/DMA-API.txt
 
 
-데이터 의존성 배리어
---------------------
+데이터 의존성 배리어 (역사적)
+-----------------------------
+
+리눅스 커널 v4.15 기준으로, smp_read_barrier_depends() 가 READ_ONCE() 에
+추가되었는데, 이는 이 섹션에 주의를 기울여야 하는 사람들은 DEC Alpha 아키텍쳐
+전용 코드를 만드는 사람들과 READ_ONCE() 자체를 만드는 사람들 뿐임을 의미합니다.
+그런 분들을 위해, 그리고 역사에 관심 있는 분들을 위해, 여기 데이터 의존성
+배리어에 대한 이야기를 적습니다.
 
 데이터 의존성 배리어의 사용에 있어 지켜야 하는 사항들은 약간 미묘하고, 데이터
 의존성 배리어가 사용되어야 하는 상황도 항상 명백하지는 않습니다.  설명을 위해
@@ -2802,8 +2808,9 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 
 
 여기에 개입하기 위해선, 데이터 의존성 배리어나 읽기 배리어를 로드 오퍼레이션들
-사이에 넣어야 합니다.  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성
-큐를 처리하도록 강제하게 됩니다.
+사이에 넣어야 합니다 (v4.15 부터는 READ_ONCE() 매크로에 의해 무조건적으로
+그렇게 됩니다).  이렇게 함으로써 캐시가 다음 요청을 처리하기 전에 일관성 큐를
+처리하도록 강제하게 됩니다.
 
 	CPU 1		CPU 2		COMMENT
 	===============	===============	=======================================
@@ -2833,9 +2840,9 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 액세스를 위해서도 이 분할된 캐시들 사이의 조정을 해야만 합니다.  Alpha 는 가장
 약한 메모리 순서 시맨틱 (semantic) 을 선택함으로써 메모리 배리어가 명시적으로
 사용되지 않았을 때에는 그런 조정이 필요하지 않게 했으며, 이는 Alpha 가 당시에
-더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, Alpha 아키텍쳐 전용
-코드와 READ_ONCE() 매크로 내부에서를 제외하고는 smp_read_barrier_depends() 가
-사용되지 않아야 함을 알아두시기 바랍니다.
+더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, (다시 말하건대, v4.15
+이후부터는) Alpha 아키텍쳐 전용 코드와 READ_ONCE() 매크로 내부에서를 제외하고는
+smp_read_barrier_depends() 가 사용되지 않아야 함을 알아두시기 바랍니다.
 
 
 캐시 일관성 VS DMA
@@ -2997,7 +3004,9 @@ Alpha CPU 의 일부 버전은 분할된 데이터 캐시를 가지고 있어서
 메모리 일관성 시스템과 함께 두개의 캐시를 동기화 시켜서, 포인터 변경과 새로운
 데이터의 발견을 올바른 순서로 일어나게 하기 때문입니다.
 
-리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다.
+리눅스 커널의 메모리 배리어 모델은 Alpha 에 기초해서 정의되었습니다만, v4.15
+부터는 리눅스 커널이 READ_ONCE() 내에 smp_read_barrier_depends() 를 추가해서
+Alpha 의 메모리 모델로의 영향력이 크게 줄어들긴 했습니다.
 
 위의 "캐시 일관성" 서브섹션을 참고하세요.
 
-- 
2.5.2
