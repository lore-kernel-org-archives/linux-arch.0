From: Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v12 10/13] tracing,
 arm64: untag user pointers in seq_print_user_ip
Date: Mon, 18 Mar 2019 18:17:42 +0100
Message-ID: <9733fd0b723aab6bcf4369fe366104ba795eb5a9.1552929301.git.andreyknvl__36990.9319373377$1552929603$gmane$org@google.com>
References: <cover.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@k
Cc: Kevin Brodsky <kevin.brodsky@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Lee Smith <Lee.Smith@arm.com>, Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy Stepanov <eugenis@google.com>
List-Id: linux-arch.vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

seq_print_user_ip() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/trace/trace_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 54373d93e251..6376bee93c84 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -370,6 +370,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 {
 	struct file *file = NULL;
 	unsigned long vmstart = 0;
+	unsigned long untagged_ip = untagged_addr(ip);
 	int ret = 1;
 
 	if (s->full)
@@ -379,7 +380,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 		const struct vm_area_struct *vma;
 
 		down_read(&mm->mmap_sem);
-		vma = find_vma(mm, ip);
+		vma = find_vma(mm, untagged_ip);
 		if (vma) {
 			file = vma->vm_file;
 			vmstart = vma->vm_start;
@@ -388,7 +389,7 @@ static int seq_print_user_ip(struct trace_seq *s, struct mm_struct *mm,
 			ret = trace_seq_path(s, &file->f_path);
 			if (ret)
 				trace_seq_printf(s, "[+0x%lx]",
-						 ip - vmstart);
+						 untagged_ip - vmstart);
 		}
 		up_read(&mm->mmap_sem);
 	}
-- 
2.21.0.225.g810b269d1ac-goog
