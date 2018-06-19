Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45396 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756270AbeFSJ0S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jun 2018 05:26:18 -0400
Date: Tue, 19 Jun 2018 11:26:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: Improve cmpxchng syscall implementation
Message-ID: <20180619092614.GD2494@hirez.programming.kicks-ass.net>
References: <20180319110002.27419-1-abrodkin@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319110002.27419-1-abrodkin@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org
Message-ID: <20180619092614.L_ZqLqaHMWUhNXE_v0e5hF8nc0zapds3VFRfkznGLoA@z>

On Mon, Mar 19, 2018 at 02:00:02PM +0300, Alexey Brodkin wrote:
> diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
> index 5ac3b547453f..d7d3e16133d6 100644
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -47,7 +47,9 @@ SYSCALL_DEFINE0(arc_gettls)
>  SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>  {
>  	struct pt_regs *regs = current_pt_regs();
> +	struct page *page;
> +	u32 val;
> +	int ret;
>  
>  	/*
>  	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
> @@ -60,23 +62,48 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>  	/* Z indicates to userspace if operation succeded */
>  	regs->status32 &= ~STATUS_Z_MASK;
>  
> +	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
> +	if (!ret)
> +		goto fail;
>  
> +again:
>  	preempt_disable();
>  
> +	ret = __get_user(val, uaddr);
> +	if (ret == -EFAULT) {
> +		preempt_enable();
> +		ret = get_user_pages_fast((unsigned long)uaddr, 1, 1, &page);
> +		if (ret < 0)
> +			goto fail;
> +
> +		put_page(page);
> +		goto again;
> +	} else if (ret)
> +		goto fail;

goto fail with preempt disabled.

> +
> +	if (val == expected) {
> +		ret = __put_user(new, uaddr);
> +		if (!ret)
>  			regs->status32 |= STATUS_Z_MASK;
>  	}
>  
> -done:
>  	preempt_enable();
>  
> -	return uval;
> +	if (ret == -EFAULT) {
> +		ret = get_user_pages_fast((unsigned long)uaddr, 1, 1, &page);
> +		if (ret < 0)
> +			goto fail;
> +
> +		put_page(page);
> +		goto again;
> +	} else if (ret)
> +		goto fail;
> +
> +	return val;
> +
> +fail:
> +	force_sig(SIGSEGV, current);
> +	return ret;
>  }

Sorry for the delay, but I would write it like:

--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -47,7 +47,9 @@ SYSCALL_DEFINE0(arc_gettls)
 SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
 {
 	struct pt_regs *regs = current_pt_regs();
-	int uval = -EFAULT;
+	struct page *page;
+	u32 val;
+	int ret;
 
 	/*
 	 * This is only for old cores lacking LLOCK/SCOND, which by defintion
@@ -60,23 +62,46 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *,
 	/* Z indicates to userspace if operation succeded */
 	regs->status32 &= ~STATUS_Z_MASK;
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
-		return -EFAULT;
+	ret = access_ok(VERIFY_WRITE, uaddr, sizeof(*uaddr));
+	if (!ret)
+		goto fail;
 
+again:
 	preempt_disable();
 
-	if (__get_user(uval, uaddr))
-		goto done;
+	ret = __get_user(val, uaddr);
+	if (ret)
+		goto fault;
 
-	if (uval == expected) {
-		if (!__put_user(new, uaddr))
-			regs->status32 |= STATUS_Z_MASK;
-	}
+	if (val != expected)
+		goto out;
 
-done:
+	ret = __put_user(new, uaddr);
+	if (ret)
+		goto fault;
+
+	regs->status32 |= STATUS_Z_MASK;
+
+out:
 	preempt_enable();
+	return val;
+
+fault:
+	preempt_enable();
+
+	if (unlikely(ret != -EFAULT))
+		goto fail;
 
-	return uval;
+	down_read(&current->mm->mmap_sem);
+	ret = fixup_user_fault(current, current->mm, uaddr, FAULT_FLAG_WRITE, NULL);
+	up_read(&current->mm->mmap_sem);
+
+	if (likely(!ret))
+		goto again;
+
+fail:
+	force_sig(SIGSEGV, current);
+	return ret;
 }
 
 #ifdef CONFIG_ISA_ARCV2
