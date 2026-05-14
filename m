Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8A23AB29B
	for <linux-arch@vger.kernel.org>; Thu, 14 May 2026 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741176; cv=none; b=X0uzKCxkBdLJBCloJFd1KH9Ry89X25PUjcXuxsZHgMv9Z38aArzWE7yds4qQXUEvSe0UJdBGMG7N50x6X/RMJHpps3CQA7yzghOQMR1mDLCChJAxcyrZe0+hERqEhyqxsK9usEc/8MXw3H38ElOlGlMEtbDA5y2JC79Zd8BwBwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741176; c=relaxed/simple;
	bh=9WoMlXctnJX7VI6xy3gmdkzNlfWMOnxsDI0zmen0z7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjrTApII8CwLNT9IwJgA1ZRppLEBvNauaAfBv+u+P6MbgQKHEZ4W/4xWhAdgMtmH11mIsQgIyO1Om4XZHyiAKTJubXCkDYkDysLSLhEyHieaRqQGTvHkyTPQVHXRsq/gICUb2NMzncCU+zrJa4x/Wu6vfeV+KiNLBT8uQ/tfBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IlZcLVwP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IlZcLVwP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so42369745e9.1
        for <linux-arch@vger.kernel.org>; Wed, 13 May 2026 23:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778741172; x=1779345972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tLK4OFCAyAlL4axAHiV7SbqndCrWYl28zniYu6/O1QY=;
        b=IlZcLVwPk0RiNQPzap2NYz2eb9006clL6A1sg0iLk2XXRnOt7IHvIJQItGnw0NdE5V
         DYKejrcj/dmJVIbaS+HFJ+2Uz6v2/+IR1vFj0ThPr07+qGPUOWaNfBWUWgYOcqebVhol
         66J3YZu2gMBaRUqgUZVYE5DyyqoFHGokpj2mfg86g6WdExVcqn+wx4RQT/8qKp6pLQ3y
         JvkcSA9r3tV6PWKBHTxA7v/CySiLTEkbnfLbsVO5XON/5zjUcWm9KVhuGAUhsMHHtnnx
         RlZE8ZWn6nHaOrunKBSAYGrFwJFPCE1mseqrBTTHMLWqslwbil0FAf+8M5Y4LLwXj8AO
         z1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741172; x=1779345972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLK4OFCAyAlL4axAHiV7SbqndCrWYl28zniYu6/O1QY=;
        b=k3PwTQ+SBJpT9eHJvi4AXp04lGsQM2PAPfJCNDFSoP5M9Vl8u5318NnjeZBjLMfld3
         Y4hFZ1oy/ATmpZcr60CsVtSEbSwYaCHtbvoHFg84q2cfIlhZeW47ybcl8l4uL6kfGBU+
         jgv9xMysEgbYRoBQp4iQKpmqKkNC3aDTqI0NWT+UK9DA8t+pD8yDuj6JjxbSpAOgGl1o
         qCugTCN7CHzIfWNPmxM9DX5wa9IFGnZDdqVjy6uOqqO6Ml6IwyPo/BwlW8DwOo+4X5Ak
         8be4E0otKs89uF7DCaLQ9boYxgNhgjha2i8qrrdQKwCyua/H61DQ/ogmcydw+e1lxzsC
         2q1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5WHJ9CQmRcMMH8PgP3Zdh1WEIBaoNZnsv2Sz0y5adnAkZbIIeEemqzf1y2nM66I0OqCMf84CtRjm5@vger.kernel.org
X-Gm-Message-State: AOJu0YzRX4M4+Mi6Tz7teZre3pyYKIPkX0GCJEn+g2zPpn5GIr3a0ZwZ
	zrikj4L7RYFa7WAX8TqPCZOI4Okkw3WATX/kS4RxRJ2yx5Vn6nodRw/hCA+Gg5v1wWk=
X-Gm-Gg: Acq92OFvfbii52bmZ1/D2/T63ddS48J+nh/JnpSctVdoGXtG2k9Vz4NCtL0A7yvCm43
	XSx17/u10tpAnYV1F/sTAI4VPGFYgNGpnMe/I5Kll/8mqnfkRYd/O984JyNDMJ+ErL09HS+bFek
	Gkhux5r0wkUgSRAy6+iNLe+iKR2EJKWk6CihYkJtu0uT7Db3yZL/m/Rps57fXZuPBc3S8Oq4SoU
	ps1qkZ+To7e59AcQt/eAhUd5OnLIRd9ocTag+itg9UnQaNpNHD1SMajEdJwhsYDRR2AVHj36Dn+
	Z9mjr2cC+aX8CijP+VnbentzB0lnF+GkxPNAVAXxlVxkAIQmYEollJEeKKSJbJUvEtsjp0fwAHv
	85LWbEEePnj1fLZXyqB0isRwv+2ffnVLLyyBPkz9k8sJ/u0zbAuxLZgdf4cn3RvwBo68I3z7HaH
	MJfrKN8wVWrtTGYdvP1GrhYNNRCeT5loNQqjjc+Vky5/VT
X-Received: by 2002:a05:600c:4ed1:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48fc9a41e96mr88986265e9.21.1778741172397;
        Wed, 13 May 2026 23:46:12 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a6454sm4465330f8f.34.2026.05.13.23.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 23:46:11 -0700 (PDT)
Message-ID: <29fa0ff2-4477-4b42-824f-c99d862786ce@suse.com>
Date: Thu, 14 May 2026 08:46:11 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] dyndbg.lds.S: fix lost dyndbg sections in modules
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
References: <20260507-asm-generic-1-v2-0-47c52759d268@gmail.com>
 <20260507-asm-generic-1-v2-5-47c52759d268@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260507-asm-generic-1-v2-5-47c52759d268@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/26 10:40 PM, Jim Cromie wrote:
> With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, several build configs had
> problems with __dyndbg* sections getting lost in drm drivers.  Fix
> this by following the model demonstrated in codetag.lds.h.
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
> [...]
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index d9d2eb708355..54897d742c6c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -332,6 +332,7 @@
>  /*
>   * .data section
>   */
> +#include <asm-generic/dyndbg.lds.h>
>  #define DATA_DATA							\
>  	*(.xiptext)							\
>  	*(DATA_MAIN)	

Nit: I suggest placing the dyndbg.lds.h include at the top of the file,
as is usual, together with the codetag.lds.h include.

Otherwise, this looks ok to me. Feel free to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
