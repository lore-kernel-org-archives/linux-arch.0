Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42174 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfH3Fhs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2019 01:37:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so2926037pgb.9
        for <linux-arch@vger.kernel.org>; Thu, 29 Aug 2019 22:37:47 -0700 (PDT)
Date: Thu, 29 Aug 2019 22:37:45 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v2 2/2] ELF: Add ELF program property parsing support
Message-ID: <201908292224.007EB4D5@keescook>
References: <1566581020-9953-1-git-send-email-Dave.Martin@arm.com>
 <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566581020-9953-3-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <20190830053745.rJ6XdNxjrThAlijsNHfHL27_nTwyFd1qfYoyE3tW398@z>

On Fri, Aug 23, 2019 at 06:23:40PM +0100, Dave Martin wrote:
> ELF program properties will needed for detecting whether to enable
> optional architecture or ABI features for a new ELF process.
> 
> For now, there are no generic properties that we care about, so do
> nothing unless CONFIG_ARCH_USE_GNU_PROPERTY=y.
> 
> Otherwise, the presence of properties using the PT_PROGRAM_PROPERTY
> phdrs entry (if any), and notify each property to the arch code.
> 
> For now, the added code is not used.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Note below...

> [...]
> +static int parse_elf_property(const char *data, size_t *off, size_t datasz,
> +			      struct arch_elf_state *arch,
> +			      bool have_prev_type, u32 *prev_type)
> +{
> +	size_t size, step;
> +	const struct gnu_property *pr;
> +	int ret;
> +
> +	if (*off == datasz)
> +		return -ENOENT;
> +
> +	if (WARN_ON(*off > datasz || *off % elf_gnu_property_align))
> +		return -EIO;
> +
> +	size = datasz - *off;
> +	if (size < sizeof(*pr))
> +		return -EIO;
> +
> +	pr = (const struct gnu_property *)(data + *off);
> +	if (pr->pr_datasz > size - sizeof(*pr))
> +		return -EIO;
> +
> +	step = round_up(sizeof(*pr) + pr->pr_datasz, elf_gnu_property_align);
> +	if (step > size)
> +		return -EIO;
> +
> +	/* Properties are supposed to be unique and sorted on pr_type: */
> +	if (have_prev_type && pr->pr_type <= *prev_type)
> +		return -EIO;
> +	*prev_type = pr->pr_type;
> +
> +	ret = arch_parse_elf_property(pr->pr_type,
> +				      data + *off + sizeof(*pr),
> +				      pr->pr_datasz, ELF_COMPAT, arch);

I find it slightly hard to read the "cursor" motion in this parse. It
feels strange, for example, to refer twice to "data + *off" with the
second including consumed *pr size. Everything is fine AFAICT in the math,
though, and I haven't been able to construct a convincingly "cleaner"
version. Maybe:

	data += *off;
	pr = (const struct gnu_property *)data;
	data += sizeof(*pr);
	...
	ret = arch_parse_elf_property(pr->pr_type, data,
				      pr->pr_datasz, ELF_COMPAT, arch);

But that feels disjoint from the "step" calculation, so... I think what
you have is fine. :)

-- 
Kees Cook
