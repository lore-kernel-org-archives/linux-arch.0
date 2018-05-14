From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 2/8] kokr/doc: READ_ONCE() now implies smp_barrier_depends()
Date: Mon, 14 May 2018 15:55:27 -0700
Message-ID: <1526338533-6044-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514225457.GA5142@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514225457.GA5142@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, SeongJae Park <sj38.park@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: SeongJae Park <sj38.park@gmail.com>

This commit applies an upstream change, commit 40555946447a ("doc:
READ_ONCE() now implies smp_barrier_depends()") to the Korean version
document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index 0a0930ab4156..edef154d77b2 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -255,17 +255,20 @@ CPU 에게 기대할 수 있는 최소한의 보장사항 몇가지가 있습니
  (*) 어떤 CPU 든, 의존성이 존재하는 메모리 액세스들은 해당 CPU 자신에게
      있어서는 순서대로 메모리 시스템에 수행 요청됩니다. 즉, 다음에 대해서:
 
-	Q = READ_ONCE(P); smp_read_barrier_depends(); D = READ_ONCE(*Q);
+	Q = READ_ONCE(P); D = READ_ONCE(*Q);
 
      CPU 는 다음과 같은 메모리 오퍼레이션 시퀀스를 수행 요청합니다:
 
 	Q = LOAD P, D = LOAD *Q
 
-     그리고 그 시퀀스 내에서의 순서는 항상 지켜집니다.  대부분의 시스템에서
-     smp_read_barrier_depends() 는 아무일도 안하지만 DEC Alpha 에서는
-     명시적으로 사용되어야 합니다.  보통의 경우에는 smp_read_barrier_depends()
-     를 직접 사용하는 대신 rcu_dereference() 같은 것들을 사용해야 함을
-     알아두세요.
+     그리고 그 시퀀스 내에서의 순서는 항상 지켜집니다.  하지만, DEC Alpha 에서
+     READ_ONCE() 는 메모리 배리어 명령도 내게 되어 있어서, DEC Alpha CPU 는
+     다음과 같은 메모리 오퍼레이션들을 내놓게 됩니다:
+
+	Q = LOAD P, MEMORY_BARRIER, D = LOAD *Q, MEMORY_BARRIER
+
+     DEC Alpha 에서 수행되든 아니든, READ_ONCE() 는 컴파일러로부터의 악영향
+     또한 제거합니다.
 
  (*) 특정 CPU 내에서 겹치는 영역의 메모리에 행해지는 로드와 스토어 들은 해당
      CPU 안에서는 순서가 바뀌지 않은 것으로 보여집니다.  즉, 다음에 대해서:
-- 
2.5.2
