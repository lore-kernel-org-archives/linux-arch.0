From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 5/5] ARM: asm/div64.h: adjust to generic codde
Date: Thu, 19 Nov 2015 11:42:45 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1511191137350.22569@knanqh.ubzr>
References: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org> <1446503610-6942-6-git-send-email-nicolas.pitre@linaro.org> <yw1xvb8ydk00.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-474433807-1447951366=:22569"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34096 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933972AbbKSQms (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 11:42:48 -0500
Received: by qgeb1 with SMTP id b1so54777497qge.1
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2015 08:42:47 -0800 (PST)
In-Reply-To: <yw1xvb8ydk00.fsf@unicorn.mansr.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-474433807-1447951366=:22569
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 19 Nov 2015, Måns Rullgård wrote:

> Nicolas Pitre <nicolas.pitre@linaro.org> writes:
> 
> > +static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool bias)
> > +{
> > +	unsigned long long res;
> > +	unsigned int tmp = 0;
> > +
> > +	if (!bias) {
> > +		asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
> > +			"mov	%Q0, #0"
> > +			: "=&r" (res)
> > +			: "r" (m), "r" (n)
> > +			: "cc");
> > +	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
> > +		res = m;
> > +		asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
> > +			"mov	%Q0, #0"
> > +			: "+&r" (res)
> > +			: "r" (m), "r" (n)
> > +			: "cc");
> > +	} else {
> > +		asm (	"umull	%Q0, %R0, %Q2, %Q3\n\t"
> > +			"cmn	%Q0, %Q2\n\t"
> > +			"adcs	%R0, %R0, %R2\n\t"
> > +			"adc	%Q0, %1, #0"
> > +			: "=&r" (res), "+&r" (tmp)
> > +			: "r" (m), "r" (n)
> 
> Why is tmp using a +r constraint here?  The register is not written, so
> using an input-only operand could/should result in better code.  That is
> also what the old code did.

No, it is worse. gcc allocates two registers because, somehow, it 
doesn't think that the first one still holds zero after the first usage.  
This way usage of only one temporary register is forced throughout, 
producing better code.

I meant to have this split out in a separate patch but messed it up 
somehow.



> 
> > +			: "cc");
> > +	}
> > +
> > +	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
> > +		asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
> > +			"umlal	%R0, %Q0, %Q1, %R2\n\t"
> > +			"mov	%R0, #0\n\t"
> > +			"umlal	%Q0, %R0, %R1, %R2"
> > +			: "+&r" (res)
> > +			: "r" (m), "r" (n)
> > +			: "cc");
> > +	} else {
> > +		asm (	"umlal	%R0, %Q0, %R2, %Q3\n\t"
> > +			"umlal	%R0, %1, %Q2, %R3\n\t"
> > +			"mov	%R0, #0\n\t"
> > +			"adds	%Q0, %1, %Q0\n\t"
> > +			"adc	%R0, %R0, #0\n\t"
> > +			"umlal	%Q0, %R0, %R2, %R3"
> > +			: "+&r" (res), "+&r" (tmp)
> > +			: "r" (m), "r" (n)
> > +			: "cc");
> > +	}
> > +
> > +	return res;
> > +}
> 
> -- 
> Måns Rullgård
> mans@mansr.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
--8323328-474433807-1447951366=:22569--
