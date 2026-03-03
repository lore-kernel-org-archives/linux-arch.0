Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A4239183D;
	Tue,  3 Mar 2026 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547810; cv=none; b=HsYUUcH2jEvFmj5goUNXij2aDs4d+B9gDFXwEoQKKUXV9XEw6SUk8TKXQYh020yFvyC9mdEX5TIGaSNJDNSyNTH6QgZxerrPtY6J3qoryx4bafG2k33jsp5J4UsmNmmJPsgZ4KzX/fzMpxao17oWl/wQ6wxIPnLTwbKzsqPrrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547810; c=relaxed/simple;
	bh=Je4OV4hkw09I1QtAT6SMBbAN3iAzNxXFYdb1OSu2IEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkvF+mYGBjj553cNOEYNzszmLPKZRjfQoOZeKTh2NgBC8cpBd9x2xmaFQkPOjYF13Uha0X/AXpFujWmLlhNkahHwQtwqKP7srP76iqjE+yUJZl3rtsj1oJKoiK0QdnvJ0LAQAoNZZzRc4IC40W8hnd3Dcu+cRkYK96s5ITAlUqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S2c71Kju; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S2c71Kju"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=V9K9eHwrlIRGUDb9b+vJ+/q2wTIDQ/HfwDI0lgkynIY=; b=S2c71KjujlLy3Uj7Ja/KnErDje
	tWvlO9jIn+2+wBCqKNXICTJVdOBcONZhDBzgwYZgIMbLTEMaCj7C4Uv3vpKYIuD4LNahQBCPI2KAU
	upEy8iT7LV+D75RpxSZKHqx2N6AZOya+DOkksC326FIb3DRJwjvwDDR17EccGYnRyyNrk+jIr0+uO
	+te19htxb7DF7U0OFxeOcrZzJY026J7YWgeHNoHJo1Bl/AiHhYsqaWGnaDTLoGGym88EZTLKu5Z2j
	E0lHsfSFL88cTdSexdmEXW/2IpeKlL5bepVT6ldjegEpzTgyaBk2UjXArZ6QqtXz0UZHFBSmIEgjN
	RjQPA29Q==;
Received: from [177.172.125.177] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vxQeX-008UJL-Hb; Tue, 03 Mar 2026 15:23:13 +0100
Message-ID: <e619c5fd-2e92-49a4-897f-8497980b417a@igalia.com>
Date: Tue, 3 Mar 2026 11:23:07 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] futex: add missing function parameter comments
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20260228071759.2663907-1-rdunlap@infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260228071759.2663907-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Randy,

Thanks for your patch

Em 28/02/2026 04:17, Randy Dunlap escreveu:
> Correct or add the missing function parameter kernel-doc comments
> to avoid warnings:
> 
> Warning: include/asm-generic/futex.h:38 function parameter 'op' not
>   described in 'futex_atomic_op_inuser_local'
> Warning: include/asm-generic/futex.h:38 function parameter 'oparg' not
>   described in 'futex_atomic_op_inuser_local'
> Warning: include/asm-generic/futex.h:38 function parameter 'oval' not
>   described in 'futex_atomic_op_inuser_local'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: André Almeida <andrealmeid@igalia.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arch@vger.kernel.org
> 
>   include/asm-generic/futex.h |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- linux-next-20260211.orig/include/asm-generic/futex.h
> +++ linux-next-20260211/include/asm-generic/futex.h
> @@ -25,7 +25,9 @@
>    *			  argument and comparison of the previous
>    *			  futex value with another constant.
>    *
> - * @encoded_op:	encoded operation to execute
> + * @op:		encoded operation to execute

I think we don't need the "encoded" part anymore

> + * @oparg:	operation code (one of FUTEX_OP_...)

This is the argument of the operation, e.g when op is FUTEX_OP_ADD, 
oparg is the value to be added.

> + * @oval:	previous value at @uaddr on successful return
>    * @uaddr:	pointer to user space address
>    *
>    * Return:

