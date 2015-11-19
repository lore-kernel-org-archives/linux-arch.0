From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 5/5] ARM: asm/div64.h: adjust to generic codde
Date: Thu, 19 Nov 2015 16:36:15 +0000
Message-ID: <yw1xvb8ydk00.fsf@unicorn.mansr.com>
References: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
	<1446503610-6942-6-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:50885 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934177AbbKSQgQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2015 11:36:16 -0500
In-Reply-To: <1446503610-6942-6-git-send-email-nicolas.pitre@linaro.org>
	(Nicolas Pitre's message of "Mon, 02 Nov 2015 17:33:30 -0500")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Nicolas Pitre <nicolas.pitre@linaro.org> writes:

> +static inline uint64_t __arch_xprod_64(uint64_t m, uint64_t n, bool =
bias)
> +{
> +	unsigned long long res;
> +	unsigned int tmp =3D 0;
> +
> +	if (!bias) {
> +		asm (	"umull	%Q0, %R0, %Q1, %Q2\n\t"
> +			"mov	%Q0, #0"
> +			: "=3D&r" (res)
> +			: "r" (m), "r" (n)
> +			: "cc");
> +	} else if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
> +		res =3D m;
> +		asm (	"umlal	%Q0, %R0, %Q1, %Q2\n\t"
> +			"mov	%Q0, #0"
> +			: "+&r" (res)
> +			: "r" (m), "r" (n)
> +			: "cc");
> +	} else {
> +		asm (	"umull	%Q0, %R0, %Q2, %Q3\n\t"
> +			"cmn	%Q0, %Q2\n\t"
> +			"adcs	%R0, %R0, %R2\n\t"
> +			"adc	%Q0, %1, #0"
> +			: "=3D&r" (res), "+&r" (tmp)
> +			: "r" (m), "r" (n)

Why is tmp using a +r constraint here?  The register is not written, so
using an input-only operand could/should result in better code.  That i=
s
also what the old code did.

> +			: "cc");
> +	}
> +
> +	if (!(m & ((1ULL << 63) | (1ULL << 31)))) {
> +		asm (	"umlal	%R0, %Q0, %R1, %Q2\n\t"
> +			"umlal	%R0, %Q0, %Q1, %R2\n\t"
> +			"mov	%R0, #0\n\t"
> +			"umlal	%Q0, %R0, %R1, %R2"
> +			: "+&r" (res)
> +			: "r" (m), "r" (n)
> +			: "cc");
> +	} else {
> +		asm (	"umlal	%R0, %Q0, %R2, %Q3\n\t"
> +			"umlal	%R0, %1, %Q2, %R3\n\t"
> +			"mov	%R0, #0\n\t"
> +			"adds	%Q0, %1, %Q0\n\t"
> +			"adc	%R0, %R0, #0\n\t"
> +			"umlal	%Q0, %R0, %R2, %R3"
> +			: "+&r" (res), "+&r" (tmp)
> +			: "r" (m), "r" (n)
> +			: "cc");
> +	}
> +
> +	return res;
> +}

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
