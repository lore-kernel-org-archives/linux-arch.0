Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f74.google.com ([209.85.161.74]:49482 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfCTOwK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Mar 2019 10:52:10 -0400
Received: by mail-yw1-f74.google.com with SMTP id v123so3389684ywf.16
        for <linux-arch@vger.kernel.org>; Wed, 20 Mar 2019 07:52:09 -0700 (PDT)
Date: Wed, 20 Mar 2019 15:51:22 +0100
In-Reply-To: <cover.1553093420.git.andreyknvl@google.com>
Message-Id: <dc4aa5f958ea98ff0add6350ec238acdc6523779.1553093421.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1553093420.git.andreyknvl@google.com>
Subject: [PATCH v13 08/20] fs, arm64: untag user pointers in fs/userfaultfd.c
From: Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Kees Cook <keescook@chromium.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan <shuah@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Yishai Hadas <yishaih@mellanox.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Jens Wiklander <jens.wiklander@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, linux-media@vger.kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Kostya Serebryany <kcc@google.com>, Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>, Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>, Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Chintan Pandya <cpandya@codeaurora.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

userfaultfd_register() and userfaultfd_unregister() use provided user
pointers for vma lookups, which can only by done with untagged pointers.

Untag user pointers in these functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 89800fc7dc9d..a3b70e0d9756 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1320,6 +1320,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
+	uffdio_register.range.start =
+		untagged_addr(uffdio_register.range.start);
+
 	ret = validate_range(mm, uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
@@ -1507,6 +1510,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
+	uffdio_unregister.start = untagged_addr(uffdio_unregister.start);
+
 	ret = validate_range(mm, uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
-- 
2.21.0.225.g810b269d1ac-goog
