Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02932346AE6
	for <linux-arch@vger.kernel.org>; Fri,  6 Mar 2026 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789915; cv=none; b=bu0R1R/KkXuV80hw3LMhvnZ0NaTvGQGs/hb49GdJKDLWamYL2CAia00iF1BFG3vXHzXJxqQfBFy8kfAw5E9koXu57+IuWgO8VAytbDSP+V9tBj7JRIK3jUhGKrf54bJuW6KfnCmE1ztJHxdmzJV369xDvmmGAVHDHSLEBhbXe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789915; c=relaxed/simple;
	bh=cU2wNTra9723kV/tr6l5eppK6Q8QRnq+Gk85QesqItU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PoPlX7GCLEyvxYmbH/Pk1xzzZydRZ/hfxqTXJKO4qtyWciQJh6IZBPG9mD5owMB+YeO9DC0Txvl/GYQf8IHF8wQu3DjOzzIvIv9i4i32Kn37iQ0/3wyVNXC/B6JozKqqSKjfZI0AhPFx9M7/kQ5XiT96LmSKjTy0pThyRJHg9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ffc879c1aeso1164380137.2
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2026 01:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789912; x=1773394712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bls+i4as7Lze2x+LjgSXb+odWTNfhZRM2QQTzPDuV4o=;
        b=ZhnXz+7bffhCbLPfwAxsyQL4saJkaVPNu0UHUbvHj8RXW3ncrkWaamSqqmSJGcIC5n
         owfXL7PMUt25zUos4slHeBxdaWmNB8XJJ7oNhHUOP5NUshSHP3cg++LqKFZcGpYKvRMT
         iPpukYigfiYcbrH5DnZUpw7YWXLxO7DPbFcbAP0mRWwUzD1+4P0rNsWhsBtO663MooD8
         7Xp3Fbyc5yQUIVtodtL6qbkKCrS+8fVFSbcH3PHIbgLHr1+/2D2W/0COPESsetp40wAi
         S9J6vdzEPflyzxDPX5AjOJSt5XddIM9oiivTOYw4HeGRKIGgfeIkekjknyPSAkd8dOEz
         AITw==
X-Forwarded-Encrypted: i=1; AJvYcCUAVNqFGqnV73F5Kl9QyIe8eefui0gOrIMjoA/9RIXcP/jPNXTlTv0jTZsUBs5XUxShGR3V41Hf/wKA@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQtFjOvPyn5XgkndvzHcPv3VJH9gXlBQwaq+BFAHX5rCTLlrn
	B1GNmCo3us10HqMW9OOqV6LKSiqOKS3OwmdAZYFZkXrmB8z2qQTmBKFM98f8zvZI4kw=
X-Gm-Gg: ATEYQzzjtEZ3DhgmId+uY+GDf0tCr015ngGufS2tWhntLNm1aySyH6yQiSKpxR5k9IV
	jKi4Emzll0PfSgEBAfEzpQ4lxhnIy6MjL8qpCRAU8iLcJJ7QFfgKQa9jm8/sFSKvwrbpFjHav28
	lWVANlDFQHQHhn4XCadsECNprYydLTs5vJscVyWYH99bhDZwnltzvtNepUau8s7Ykx+8hVJb7DB
	zduIXXNoKNQf7mkyhn4bXlzdwAYsS+TUlEGXhz68k2hTHupnm/8nJpam5OZoy8A3suu9SVa5l1E
	E/u7jba2vC0ZS+QtrrVH87oqMalTfZvPGY/VuvpF+Rvx7P/zCTAa9rKgyUl92EGJd2x9dFpOxNs
	SR3Ykod43zD+d83ZAcFp+BpukNvgVJfuU7BDB7/0grY/C0+G/cfcbTCUsAfffB0tduQxQKv3IEI
	1K6RosgzKeSmu0jkWsf7bGtv8WIugWsT0Vi+MBjtBFtx3r1t5H+Mg+z7n7r5lD
X-Received: by 2002:a05:6102:38ce:b0:5ff:1d94:b746 with SMTP id ada2fe7eead31-5ffe6183273mr588735137.27.1772789911725;
        Fri, 06 Mar 2026 01:38:31 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94e7b30a7dfsm846676241.1.2026.03.06.01.38.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 01:38:31 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-94acb3d6cceso5118971241.2
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2026 01:38:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJkoIO+U/ol7T30CElusBr6+OtUFW+NVBPKGOIT2ZbXLkxUzOWMfYOB6X62ORaD66oDqp3E5CtP8aY@vger.kernel.org
X-Received: by 2002:a05:6102:c8d:b0:5ff:b684:f7a0 with SMTP id
 ada2fe7eead31-5ffe61dddb7mr585849137.30.1772789910765; Fri, 06 Mar 2026
 01:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306075009.83723-1-academic1mathura@gmail.com>
In-Reply-To: <20260306075009.83723-1-academic1mathura@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 6 Mar 2026 10:38:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDeeeJH3x09YuZ-86=FPfwZg0mD5Gwnqvk7U_QT1eOhw@mail.gmail.com>
X-Gm-Features: AaiRm53rff3F-5Tq7LbrSA5mZ3FGA4E7qSiG13WNW2wBQzc-o21-AqX_icFuxGo
Message-ID: <CAMuHMdXDeeeJH3x09YuZ-86=FPfwZg0mD5Gwnqvk7U_QT1eOhw@mail.gmail.com>
Subject: Re: [PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
 mq_peek syscall] for non-destructive receive and inspection,fix minor
 issue,prepared doc.
To: Mathura_Kumar <academic1mathura@gmail.com>
Cc: brauner@kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Hi Mathura,

CC Arnd

Thanks for your patch!

On Fri, 6 Mar 2026 at 08:50, Mathura_Kumar <academic1mathura@gmail.com> wrote:
>  Change from v3 to v5:
>
>  -Styles issue fixed
>  -Doc was prepared/modified in Documentation/userspace-api/ipc.rst,
>  -Corrected file references
>  -I am squashing previous four commit in this latest one for convenience  in applying
>   and merging
>  -risc-v related macro handling error fixed
>  -some struct definition removed from ipc/mqueue.c for better compiler control flow
>
> Required Attention:-As per mail from bot

What does this mean?

>
> kernel test robot noticed the following build errors:
> [auto build test ERROR on shuah-kselftest/next]
> [also build test ERROR on shuah-kselftest/fixes next-20260304]
> [cannot apply to arnd-asm-generic/master linus/master tip/x86/asm v6.16-rc1]
>
> Short Description:
>     POSIX message queues currently lack a mechanism to read
>     a message without removing it from the queue. This is a
>     long-standing limitation,when we require inspection of queue state
>     without altering it.
>
>     Modifying existing mq_receive() semantics via additional
>     flags was considered. However, altering behavior of an
>     existing syscall risks breaking backward compatibility
>     for applications relying on current semantics. Since
>     mq_receive() guarantees message removal, changing this
>     contract is not safe.
>
>     To preserve ABI stability, this patch introduces a new
>     system call that performs a non-destructive receive
>     operation (peek). The existing behavior remains unchanged.
>
>     Design considerations:
>
>     Two approaches for copying message data to userspace
>     were evaluated:
>
>     1) Refcount-based message lifecycle handling
>        - This can help us  Avoids intermediate temp kernel copy
>        - Extends message lifetime
>        -But this may increase writer starvation under heavy load and
>         add unnecessary complication on priority  management and
>         delay more time to free space in inode due refcount may prevent
>
>     2) Temporary kernel buffer copy
>        - Copies message into a bounded kernel buffer
>        - Reduces time message remains locked
>        - Improves fairness under write-heavy workloads
>        - Simpler lifetime management
>
>     My implementation adopts the temporary buffer approach
>     to minimize starvation and reduce locking complexity.
>     The design allows future transition if refcounting is
>     deemed preferable.
>
>     Architecture support: ALL
>
>     Testing:
>       - 15+ functional test cases
>       - Multi-threaded producer/consumer scenarios
>       - concurrent pop and peek
>       - Edge cases: empty queue, FIFO
>         invalid flags, signal interruption etc.
>
> Use Case:
>
> 1) Observability in distributed systems
>  e.g Monitoring tools can inspect queue contents without interfering with
>     normal processing
>
> 2) Check pointing system can have a look into queue without consuming and can store messages
>
> 3) Resource-aware processing
>
> 4) Selective Consumption for Specialized Workers
>
> Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>

> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst

> --- /dev/null
> +++ b/Documentation/userspace-api/ipc.rst
> @@ -0,0 +1,273 @@

> +1) Overview
> +-----------
> +
> +POSIX message queues on Linux provide mq_receive() and mq_timedreceive()
> +for consuming messages from a queue. Both interfaces require the caller
> +to pass the message buffer, length, and priority pointer as individual
> +arguments to the system call. This imposes a fixed calling convention
> +that cannot be extended without breaking the ABI.
> +
> +mq_timedreceive2() introduces a new system call entry point that accepts
> +message buffer parameters via a struct argument rather than as individual
> +syscall arguments. This frees the remaining syscall argument slots for
> +new functionality flags and a message index, enabling non-destructive
> +peek and indexed access semantics that are not possible with the
> +original interface.
> +
> +Two variants are provided:
> +
> +  mq_timedreceive2()         - primary variant, 64-bit time (Y2038-safe)
> +  mq_timedreceive2_time32()  - 32-bit time variant for legacy and compat

What is the rationale behind adding a new syscall that is not Y2038-safe?

> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -486,3 +486,5 @@
>  469    common  file_setattr                    sys_file_setattr
>  470    common  listns                          sys_listns
>  471    common  rseq_slice_yield                sys_rseq_slice_yield
> +472    common  mq_timedreceive2                sys_mq_timedreceive2_time32
> +473    common  mq_timedreceive2_time64 sys_mq_timedreceive2
> diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
> index 62d93d88e0fe..02603704231e 100644
> --- a/arch/arm64/tools/syscall_32.tbl
> +++ b/arch/arm64/tools/syscall_32.tbl
> @@ -483,3 +483,5 @@
>  469    common  file_setattr                    sys_file_setattr
>  470    common  listns                          sys_listns
>  471    common  rseq_slice_yield                sys_rseq_slice_yield
> +472    common  mq_timedreceive2_time64 sys_mq_timedreceive2
> +473    common  mq_timedreceive2                sys_mq_timedreceive2_time32
> diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
> index 248934257101..b67f23edda11 100644
> --- a/arch/m68k/kernel/syscalls/syscall.tbl
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -471,3 +471,6 @@
>  469    common  file_setattr                    sys_file_setattr
>  470    common  listns                          sys_listns
>  471    common  rseq_slice_yield                sys_rseq_slice_yield
> +472    common  mq_timedreceive2                sys_mq_timedreceive2_time32
> +473    common  mq_timedreceive2_time64 sys_mq_timedreceive2
> +
> diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
> index 223d26303627..89fb60006a99 100644
> --- a/arch/microblaze/kernel/syscalls/syscall.tbl
> +++ b/arch/microblaze/kernel/syscalls/syscall.tbl
> @@ -477,3 +477,6 @@
>  469    common  file_setattr                    sys_file_setattr
>  470    common  listns                          sys_listns
>  471    common  rseq_slice_yield                sys_rseq_slice_yield
> +472    common  mq_timedreceive2                sys_mq_timedreceive2_time32
> +473    common  mq_timedreceive2_time64 sys_mq_timedreceive2
> +
> diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
> index 7430714e2b8f..fee830be67a6 100644
> --- a/arch/mips/kernel/syscalls/syscall_n32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
> @@ -410,3 +410,5 @@
>  469    n32     file_setattr                    sys_file_setattr
>  470    n32     listns                          sys_listns
>  471    n32     rseq_slice_yield                sys_rseq_slice_yield
> +472    n32     mq_timedreceive2            sys_mq_timedreceive2_time32
> +473    n32     mq_timedreceive2_time64 sys_mq_timedreceive2

So these receive two variants...

> diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> index 630aab9e5425..75de6ee2df94 100644
> --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> @@ -386,3 +386,4 @@
>  469    n64     file_setattr                    sys_file_setattr
>  470    n64     listns                          sys_listns
>  471    n64     rseq_slice_yield                sys_rseq_slice_yield
> +472    n64     mq_timedreceive2                sys_mq_timedreceive2

MIPS64 receives only one?

> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 128653112284..8694a2d2f084 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -459,3 +459,5 @@
>  469    o32     file_setattr                    sys_file_setattr
>  470    o32     listns                          sys_listns
>  471    o32     rseq_slice_yield                sys_rseq_slice_yield
> +472    o32     mq_timedreceive2            sys_mq_timedreceive2_time32
> +473    o32     mq_timedreceive2_time64 sys_mq_timedreceive2
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 4fcc7c58a105..fd90a2f500b6 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -562,3 +562,6 @@
>  469    common  file_setattr                    sys_file_setattr
>  470    common  listns                          sys_listns
>  471    nospu   rseq_slice_yield                sys_rseq_slice_yield
> +472    32      mq_timedreceive2                sys_mq_timedreceive2_time32
> +473    64      mq_timedreceive2                sys_mq_timedreceive2
> +474    32      mq_timedreceive2_time64     sys_mq_timedreceive2          sys_mq_timedreceive2

PowerPC receives three variants?
Oh, the first two are for 32-bit vs. 64-bit, so they should use the
same syscall number.

More of this below...

Furthermore, this breaks the "new syscalls use the same number on
most architectures"-rule. Next free slot is now 472, 473, or 474,
depending on architecture.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
