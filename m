Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:1348 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbXFZGTd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jun 2007 02:19:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2126944wah
        for <linux-arch@vger.kernel.org>; Mon, 25 Jun 2007 23:19:33 -0700 (PDT)
Message-ID: <863e9df20706252319j239eaf44wee7a46ad742c9585@mail.gmail.com>
Date: Tue, 26 Jun 2007 11:49:33 +0530
From: "Abhishek Sagar" <sagar.abhishek@gmail.com>
Subject: Re: [PATCH 3/3] Make jprobes a little safer for users
In-Reply-To: <7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	 <7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-ia64@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@lst.de>, anil.s.keshavamurthy@intel.com, ananth@in.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On 6/26/07, Michael Ellerman <michael@ellerman.id.au> wrote:

> We can then use that in register_jprobe() to check that the entry point
> we're passed is actually in the kernel text, rather than just some random
> value.

A similar cleanup is possible even for return probes then. I wonder if
there are any kprobe related scenarios where the executable code may
be located outside the core kernel text region (e.g, ITCM?). In that
case would it also be wrong to assume that the jprobe handler may be
situated outside the kernel core text / module  region? Would it then
make sense to move this check from register_jprobe() to the arch
dependent code?

>  int __kprobes register_jprobe(struct jprobe *jp)
>  {
> +       unsigned long addr = arch_deref_entry_point(jp->entry);
> +
> +       if (!kernel_text_address(addr))
> +               return -EINVAL;

Seems like you're checking for the jprobe handler to be within
kernel/module range. Why not narrow this down to just module range
(!module_text_address(addr), say)? Core kernel functions would not be
ending with a 'jprobe_return()' anyway.

--
Abhishek Sagar

-
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
