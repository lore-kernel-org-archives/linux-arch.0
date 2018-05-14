From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 3/8] kokr/doc: De-emphasize smp_read_barrier_depends
Date: Mon, 14 May 2018 15:55:28 -0700
Message-ID: <1526338533-6044-3-git-send-email-paulmck@linux.vnet.ibm.com>
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

This commit applies an upstream change, commit 9ad3c143d7d6 ("doc:
De-emphasize smp_read_barrier_depends") to the Korean version document.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 Documentation/translations/ko_KR/memory-barriers.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Documentation/translations/ko_KR/memory-barriers.txt
index edef154d77b2..44e47c2d33cf 100644
--- a/Documentation/translations/ko_KR/memory-barriers.txt
+++ b/Documentation/translations/ko_KR/memory-barriers.txt
@@ -1790,7 +1790,7 @@ CPU 메모리 배리어
 	범용		mb()			smp_mb()
 	쓰기		wmb()			smp_wmb()
 	읽기		rmb()			smp_rmb()
-	데이터 의존성	read_barrier_depends()	smp_read_barrier_depends()
+	데이터 의존성				READ_ONCE()
 
 
 데이터 의존성 배리어를 제외한 모든 메모리 배리어는 컴파일러 배리어를
@@ -2829,7 +2829,10 @@ CPU 2 는 C/D 를 갖습니다)가 병렬로 연결되어 있는 시스템을 
 다른 CPU 들도 분할된 캐시를 가지고 있을 수 있지만, 그런 CPU 들은 평범한 메모리
 액세스를 위해서도 이 분할된 캐시들 사이의 조정을 해야만 합니다.  Alpha 는 가장
 약한 메모리 순서 시맨틱 (semantic) 을 선택함으로써 메모리 배리어가 명시적으로
-사용되지 않았을 때에는 그런 조정이 필요하지 않게 했습니다.
+사용되지 않았을 때에는 그런 조정이 필요하지 않게 했으며, 이는 Alpha 가 당시에
+더 높은 CPU 클락 속도를 가질 수 있게 했습니다.  하지만, Alpha 아키텍쳐 전용
+코드와 READ_ONCE() 매크로 내부에서를 제외하고는 smp_read_barrier_depends() 가
+사용되지 않아야 함을 알아두시기 바랍니다.
 
 
 캐시 일관성 VS DMA
-- 
2.5.2
