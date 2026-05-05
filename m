Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F56A3DCD8D
	for <linux-arch@vger.kernel.org>; Tue,  5 May 2026 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965989; cv=none; b=ROkmq9C/eJ0yiUrlYruOj3FWj79CMhRMhqSYJZXaJppD+luPVYcavc0XZPfupNhkFmnXfCsO7ZrZCLvtoF3yBbA8Aju8DC+fSnCe3BX2QGOquX/9+5P5PnkLDFFCHJh2RsBoyNOGdpQ2JfSeVJsFDgxI/nieDndyNvxTMCS9u9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965989; c=relaxed/simple;
	bh=T+wbeQamq/tj3Vv47HHDIJvt1tkICVJb0cnzZ3qBaKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2/m0Qwj1WsX6cWgKfUT6xJ7MUGstBVDE3lIlBNv7UwGuLSVolFEI1cbkS2MLGy+0vYOIZ5BjQ9bhD0tlxuVObrKRhW3pSTkMZvC8Vh3CX0YFzyYmuDCOUkcpR8fzL3zUcPBeiIj0S9EcHCmon3nvQbO08KepdDVkpvlwZW2+/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LEtUayOw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LEtUayOw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so52225985e9.0
        for <linux-arch@vger.kernel.org>; Tue, 05 May 2026 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777965987; x=1778570787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BYyU/gDiNCK3Xl0s772Lu/DkeUvU8mOX4Y8Y+qgk5Zc=;
        b=LEtUayOwIGtxkPnnJYFaxO0GmSQWxek7PD6h+L7rd8gr+ks4FRd7Nm3oqsA44oFKJT
         25rbF798u+uUU9GcAW5/zoKHnU3OD7AR1YIDg9LqFUbh3T4TUj4vhufjcIpZDAiyyDE9
         FoOujVIzYwxEcXoOTuSPYqq4tbmfq4MPLOajkUoFI5ca8Hb61Ymj3v21gnaNKlRGUgJ+
         u68PEWTXhsVsZOX2MF4qEGLSexjqg/1ESDin0MItL+vh3myQVTZ98WiQYH9bg1pqC5mw
         CfJn3zZ8RzNWIWoOiCJ8no5GTtrnt3Wr3gorTOsWkAOcYivOwLh5BRmXAjp6ehTogvh2
         yC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965987; x=1778570787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BYyU/gDiNCK3Xl0s772Lu/DkeUvU8mOX4Y8Y+qgk5Zc=;
        b=cSyxhTsii/7hvdBFWD3gYo9SUESi6a0rH9xUy/8XUQsNwMIhAdBgca5suYlHnv+ovE
         ZI9kWNaDxHNR/ixDocAU+V/OEvPe0TCqEjn7BdrhxMvq4zPebn11PK+igOy3LD6KdNjJ
         q/D+PkYAm1+qHG8HvPEYtdDV4OC5S0vwyVH/seQeQdbF1+pnCCiYWcoSvaYcHTADOWbj
         N1aisI9ryOxvDMkYc5xDNxKb0MjGFL5zlOIxiXIuzz5oO2fa8CmBd8kjlNH7WCPUkzpp
         is0OjHoxpMNpsrZR3qbJ9SJTHtsyiniTzZmlr2z+IPaeBvYZWMWXU9vn35jN8ME4jTAV
         zHGA==
X-Forwarded-Encrypted: i=1; AFNElJ8awC4R+ymc5ueOpI0YBOiePZMmt92j79jQ51nGvifdV/GFFLAtMEGhKSpc6KPSs/oCJ4WFb2JL+YfS@vger.kernel.org
X-Gm-Message-State: AOJu0YyDzvfW23sl6UUMbtZIfudg5MUM2gzQZXwjcoV6BC4wRuwfOls9
	x/pnPYCXjRfhyBnB/Ft01LE+yWdkIqNSThdsoQ+PsrKiYOcs5bfoTE5jPBt/LYsEQIE=
X-Gm-Gg: AeBDiesGr3w5JzQ3UVgihfw6fPzPO0bJ1ncRJFH6xZH4NLFBFmDLlVrD+BnKjHZlqYN
	KrFmiQXoKbxS/uxNsB/9HbhJONriujIy2iLYncRyy9t8tRfTQDpNw9I9E4o5GNaFyBC/BZrPCfb
	9XG7TsN1TuCH/lO6vClZzMNwR/69C0HGY/PC1ID3MzOcrcvX0avg1d5/oN1rLnwdPQLBAwlfAaX
	Tqe+Jgb/5IiJIK1lACIVd2Zyo+dMZBf4P5TBXxtwkt5qXd/EU0pq7EQginazo7aEmIPsHmaWxvV
	DzwLZzxM8JfsV/a4cJf4wrNn9seSquo/zuBUGcvCQM+BYacTlY8EZadCxNlzfG2la3/9E8s4OMT
	dfr7Mh3ygh/pMgqAm1k0CjtfEiVxFMJgS5CctV/fm/Tdosbd9IRDs5ZKYWJTwBpFxFBB39gNbAx
	rYjYg+X7oe71JG59+mS4k9PhUmA34gqMLo2glEk+DfYzRXA5zionOLs5Y=
X-Received: by 2002:a05:600c:19d4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48d1422baefmr38657615e9.2.1777965986739;
        Tue, 05 May 2026 00:26:26 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm372787885e9.4.2026.05.05.00.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:26:26 -0700 (PDT)
Message-ID: <0487a38a-ddb0-4abd-a1f1-fd98551ccb09@suse.com>
Date: Tue, 5 May 2026 09:26:25 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20260502-asm-generic-1-v1-0-1103ee0152df@gmail.com>
 <20260502-asm-generic-1-v1-5-1103ee0152df@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260502-asm-generic-1-v1-5-1103ee0152df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/26 2:05 AM, Jim Cromie wrote:
> Several build configs had problems with __dyndbg* sections getting
> lost in drm drivers.  Fix this by following the model demonstrated in
> codetag.lds.h.
> 
> Introduce include/asm-generic/dyndbg.lds.h, to bundle dynamic-debug's
> multiple sections together, into 2 macros:
> 
> vmlinux.lds.h DATA_DATA: move the 2 BOUNDED_SECTION_BY(__dyndbg*)
> calls into dyndbg.lds.h DYNDBG_SECTIONS(). vmlinux.lds.h now includes
> the new file and calls the new macro.
> 
> MOD_DYNDBG_SECTIONS declares the 2 BOUNDED_SECTION_BY calls, but wraps
> them with output section syntax to keep them as known and separate ELF
> sections in the module.ko.  The KEEP fixes the lost section.
> 
> dyndbg.lds.h includes (reuses) bounded-section.lds.h
> 
> scripts/module.lds.S: now calls MOD_DYNDBG_SECTIONS right before the
> CODETAG macro (consistent with their placements in vmlinux.lds.h), and
> also includes dyndbg.lds.h
> 
> This isolates vmlinux.lds.h from further __dyndbg section additions.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
[...]
> diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
> new file mode 100644
> index 000000000000..f95683aa16b6
> --- /dev/null
> +++ b/include/asm-generic/dyndbg.lds.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __ASM_GENERIC_DYNDBG_LDS_H
> +#define __ASM_GENERIC_DYNDBG_LDS_H
> +
> +#include <asm-generic/bounded_sections.lds.h>
> +#define DYNDBG_SECTIONS()					\
> +	. = ALIGN(8);						\
> +	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
> +	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
> +
> +#define MOD_DYNDBG_SECTIONS()                                           \
> +	__dyndbg : {							\
> +		BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
> +	}								\
> +	__dyndbg_classes : {						\
> +		BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)	\
> +	}

The BOUNDED_SECTION_BY() macro always defines the __start and __end
symbols for the section. This is not ideal for modules because these
symbols are created even when no __dyndbg or __dyndbg_classes input
sections are present. Additionally, they cause MOD_DYNDBG_SECTIONS() to
produce dummy output sections with the same names in all modules, even
when dynamic debug is disabled in the config. This unnecessarily
pollutes the modules. Since modules are relocatable files, the usual
method for locating consolidated data in a module is to read its section
table.

The second problem is that MOD_DYNDBG_SECTIONS() should force the
address of all its output sections to 0. Otherwise, when linking modules
with 'ld.bfd -r', sections defined without an address inherit the
location counter, resulting in non-zero sh_addr values in the resulting
.ko files. Non-zero addresses are confusing in this context, typically
worse compressible, and may cause external tools to misbehave.

-- 
Thanks,
Petr
