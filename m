Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f202.google.com ([209.85.222.202]:53976 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbfCRRSP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Mar 2019 13:18:15 -0400
Received: by mail-qk1-f202.google.com with SMTP id z123so15319988qka.20
        for <linux-arch@vger.kernel.org>; Mon, 18 Mar 2019 10:18:14 -0700 (PDT)
Date: Mon, 18 Mar 2019 18:17:40 +0100
In-Reply-To: <cover.1552929301.git.andreyknvl@google.com>
Message-Id: <80e79c47dc7c5ee3572034a1d69bb724fbed2ecb.1552929301.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1552929301.git.andreyknvl@google.com>
Subject: [PATCH v12 08/13] net, arm64: untag user pointers in tcp_zerocopy_receive
From: Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

tcp_zerocopy_receive() uses provided user pointers for vma lookups, which
can only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 net/ipv4/tcp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6baa6dc1b13b..e76beb5ff1ff 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1749,7 +1749,7 @@ EXPORT_SYMBOL(tcp_mmap);
 static int tcp_zerocopy_receive(struct sock *sk,
 				struct tcp_zerocopy_receive *zc)
 {
-	unsigned long address = (unsigned long)zc->address;
+	unsigned long address;
 	const skb_frag_t *frags = NULL;
 	u32 length = 0, seq, offset;
 	struct vm_area_struct *vma;
@@ -1758,7 +1758,12 @@ static int tcp_zerocopy_receive(struct sock *sk,
 	int inq;
 	int ret;
 
-	if (address & (PAGE_SIZE - 1) || address != zc->address)
+	address = (unsigned long)untagged_addr(zc->address);
+
+	/* The second test in this if detects if the u64->unsigned long
+	 * conversion had any truncated bits.
+	 */
+	if (address & (PAGE_SIZE - 1) || address != untagged_addr(zc->address))
 		return -EINVAL;
 
 	if (sk->sk_state == TCP_LISTEN)
-- 
2.21.0.225.g810b269d1ac-goog
