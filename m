From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: [PATCH v1 0/7] tools: add linker table userspace sandbox
Date: Mon, 22 Aug 2016 11:59:46 +0200
Message-ID: <CAOMGZ=G2wVYxbg9Jerkuq0HdoB3W5SwZdiKM2zNz5EXfVYR2jQ@mail.gmail.com>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org> <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-arch@vger.kernel.org, kbuild <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

(trimmed Ccs... jeez)

On 19 August 2016 at 23:41,  <mcgrof@kernel.org> wrote:
> From: "Luis R. Rodriguez" <mcgrof@kernel.org>
>
> The original v3 series for linker tables made reference only to
> an external repository userspace sandbox application, however
> Boris noted it'd be difficult ot keep this in sync with the
> kernel so advised to consider integrate with the kernel. I've
> taken steps in this direction.
[...]
> Please let me know if there are any issue or questions.

+#define __VMLINUX_SYMBOL(x) x

+#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)

+#define LINUX_SECTION_START(name)      VMLINUX_SYMBOL(name)

+#define DECLARE_LINUX_SECTION(type, name)                              \
+        extern type VMLINUX_SYMBOL(name)[], \
+                    VMLINUX_SYMBOL(name##__end)[]

+#define DECLARE_LINKTABLE(type, name)                                  \
+       DECLARE_LINUX_SECTION(type, name)

+#define LINKTABLE_FOR_EACH(pointer, tbl)                               \
+       for (pointer = LINUX_SECTION_START(tbl);                        \
+            pointer < LINUX_SECTION_END(tbl);                          \
+            pointer++)

I think this is subject to getting optimised out by newer gccs, since
it sees the START(tbl) and END(tbl) symbols as two completely
different arrays. See the short discussion here:

https://lkml.org/lkml/2016/6/26/73 (the first attempt is wrong, so
don't look at that)

It is possible that < is different from != and always does the right
thing, but I haven't checked.

I have a WIP branch that converts most of the existing tables in the
kernel to use the external_array() macro which makes gcc throw away
any knowledge it had about a pointer being part of an array.


Vegard
