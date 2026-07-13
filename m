Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99B2848A7
	for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958529; cv=none; b=j5IiSly+9WRzT/0UCyMKaWXRfJHPpDnSnKv/TZPe6jJDg7pJIKoE56Bu07WMB+Fbt7HrBCVcYhffIDKow+xWET0AxffimOnT89Oj8xzlSw/+Xoidwgp4DUeD5EwXU0x1pmJ1BJHI2iOv2MThlEu3VfX64uZ7QA5b5KTfCl48Im0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958529; c=relaxed/simple;
	bh=EMPIvQ9f61dOFBUBMC4kCdeDHzW0UPnMbzHxxxEEbBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rA5xSFzUhdv4q/PoAk8QqLBjLS64j9Jk9x+GzcUWUU3AfJsgnJv/VBro65bt5cJ0cs0qm32eI5byIlSaW8T8qmcx8PH1BESY6uMum++USYiMB01ioAPKQgmC9UMpeIbcWXEajvu09X/Ml4+jaLF+C8SuFsPS/HMBdHcIyQxIxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L0QXbr93; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L0QXbr93"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c19bad03so30596065e9.2
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783958526; x=1784563326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzLBfZsmv8ck2KA4fjQuTLH7P1bbLfgsRuWph8WedGs=;
        b=L0QXbr93HTfJh7IquV91jQuDCU4gn1GMZFcKTZDipw8GitGCxIxh9wsYydIZRqZ08X
         MiYI9dfAZROworqsCCn8E/gcyE2CidCMdFsUiQ/wBpGrcBx40ujBKNPoytn+QyFGDhQ3
         wQE6fpWklhbbubtB0+bX4mnEJ2gb2RP1VmzsQWEw/PBFuDLDs2K7hL+zVU72x/9BJWgb
         o0pIQ9JJl9RIJyTw4iOYKAChg47lKLf+3sUONFWwOyczienRff5ANSQ21GVZ1HKPEXWM
         82Y8eyCNPWy1NMySwhD+ybCTCLcCPIHmT4pgoOGnuZM/hHb6wEeEFHAmjAn2bund/Q33
         0OwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783958526; x=1784563326;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzLBfZsmv8ck2KA4fjQuTLH7P1bbLfgsRuWph8WedGs=;
        b=N1fTcJHvIeI6yOHMVQPkWby5x6EOVpeY2CpxYJQD5cciANR4IS1KyNL2Cw7/o09KRn
         r5A1SVlVc9DpFQ0qyPJo5EaBj03am04ZM+0HknQ6/6FTAckW/gbqwc2X2ACJWYTkGhCO
         fpDucf0zYLXhN2OjNVHruLFQPy7zVWzP1FGDgEYGgJxiB/AOiFJeHIQLeoY/4IdChWrB
         WsH6ZlH8tv5gho7aFTAFKEjEpjdW2ycJbSp0fYoMGMC5LIAaeQKjS3/u5v4yX7YHES/B
         PjI+bfmDgHLUaUU4AWkRMn16+Yw/dbP1ttfsnNteQLGVYI1JsbzCFc7eGWcJbW6fM8pK
         xtwQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdQszBPtCcVNRT7NgSf4rYZGEEm8CqeBXRVpN7QaAC6yiPO2gVyjHFKZtv464hURcavCMv95eCPPf8@vger.kernel.org
X-Gm-Message-State: AOJu0YzZW4IWx+sIacn/yJAkHNlg0f/7WAnMTlPqvRArxsXbnLwr9ufB
	HhIJ1NRjuEUd65m74J592C7UdLDwZNqjzDgrPUfMLRJEigfBU39Zy05CTTpmGE4hniY=
X-Gm-Gg: AfdE7cmR2cBcXDRvOkchjAFU4dwm/89IWyvcYEsIdNe/DQM7OpaQyhd8DVRBsDodwp1
	YC8nq6a2A/bAu2NzODTkfyJlIiQYIjinQKI4hB2YO22odO58fg69q1E59Moo7+hpIn+vs7NlO/r
	Zc+1wk7jjXOB2tKSc9HndodpjZhgV1r3V3ok8swA3eXUpi5HuukCVUmrw7RFPgQ7RDZ+KdjdzHU
	n3bIU7uEQHHRUmXVE1GKLiV5OTqDH/IFlf2VjjkWjE4BTzzIH0VPsyzY+of0jIjkuDGnFHNDpg4
	oGYuF9mU9dD2hIsPWDylH+mMlUK8YGSxxlSo2xIlI7hLEgK44oY2Q5oWBIAKsyHhowh89VxmLN0
	JI9+4c7MHwkn/p00dXIWQYa/lCSvQo4NgwKyxD9PTnAHqi3Y29Zu/SvK2AysR6LZZfIHQrXR8T8
	o56iOh/ZlzqgP5XABbykBRpqa1hEhTz04xrmb0SU5GCdtW
X-Received: by 2002:a05:600c:8119:b0:493:b6e4:fb2b with SMTP id 5b1f17b1804b1-493f882cc20mr90387845e9.25.1783958526083;
        Mon, 13 Jul 2026 09:02:06 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm5002855e9.14.2026.07.13.09.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 09:02:05 -0700 (PDT)
Message-ID: <c54ab73d-8b96-4dcc-8847-63c54da6b799@suse.com>
Date: Mon, 13 Jul 2026 18:02:04 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] module: Extend module_blacklist parameter to built-in
 modules
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 da.gomez@kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, neelx@suse.com, da.anzani@gmail.com,
 sean@ashe.io, chjohnst@mail.com, steve@abita.co, mproche@mail.com,
 nick.lane@mail.com, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260708020007.55728-1-atomlin@atomlin.com>
 <33171ccd-038b-4bb8-b796-f104a131c0ee@app.fastmail.com>
 <in7aczdvb22suqhao6uzsjkh22tgyx2qug4i6efdxyfiuj72ba@k6fr4oc27kim>
 <78ec1da5-11ae-4c35-a08e-cc88a5d083f4@app.fastmail.com>
 <ea7kdjwoucecvetzf73ce5dpda3l3etb6i75bks6deekfu6mb6@ooptba3x2oh3>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <ea7kdjwoucecvetzf73ce5dpda3l3etb6i75bks6deekfu6mb6@ooptba3x2oh3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 2:13 PM, Aaron Tomlin wrote:
> On Mon, Jul 13, 2026 at 10:32:14AM +0200, Arnd Bergmann wrote:
>> On Sat, Jul 11, 2026, at 01:13, Aaron Tomlin wrote:
>>> On Fri, Jul 10, 2026 at 05:59:59PM +0200, Arnd Bergmann wrote:
>>>> On Wed, Jul 8, 2026, at 04:00, Aaron Tomlin wrote:
>>>>> Currently, the "module_blacklist=" command-line parameter only applies
>>>>> to loadable modules. If a module is built-in, the parameter is silently
>>>>> ignored. This patch extends the blacklisting functionality to built-in
>>>>> modules by intercepting their initialisation routines during early boot.
>>>>
>>>> Andrew already asked you to provide more background on what you need
>>>> this part for. Do you have a specific driver you need to disable?
>>>>
>>>> Can't you do the same thing using initcall_blacklist?
>>>
>>> The primary motivation for this patch is to provide consistent
>>> administrative control.
>>
>> Ok, it sounds like you don't actually need it then.
>>
>>> Regarding your suggestion to use initcall_blacklist=, while it is certainly
>>> a capable mechanism, it is fundamentally considered a debugging facility
>>> intended for developers.
>>
>> I don't see much of a difference here, it's clearly still only a
>> debugging tool to me, not a general administrative interface: turning
>> off a random built-in driver likely causes undefined behavior later
>> if there are any other drivers (built-in or loaded) that depend on it.
>>
>> Overall I don't think it's worth the added complexity.
> 
> Hi Arnd,
> 
> I appreciate your candour, but I must respectfully disagree with the
> assessment that this is merely a debugging tool with no practical
> necessity.
> 
> The requirement stems from large-scale infrastructure management and
> configuration consistency. System administrators rely on standard
> provisioning scripts across diverse hardware. If a distribution arbitrarily
> alters a kernel configuration, changing a module from loadable (=m) to
> built-in (=y), the administrator's module_blacklist= directive is suddenly
> and silently ignored. This creates a severe policy enforcement gap.

Note that a gap will still exist if the administrator previously
blacklisted a specific loadable module using the blacklist command in
/etc/modprobe.d/ instead of the module_blacklist kernel parameter.

> 
> Regarding the distinction between initcall_blacklist= and
> module_blacklist=, the difference lies entirely in ABI stability.
> To use initcall_blacklist= requires the administrator to know the exact
> internal C function name of the initialisation routine (e.g.,
> foo_driver_init). This is an internal kernel implementation detail, subject
> to change without notice, and entirely undocumented for users. Conversely,
> the module name is a stable, well-known, and documented user-facing
> identifier. Providing a stable interface for administrative policy is the
> very definition of a general administrative tool, rather than a developer
> debugging facility.
> For example, consider CVE-2021-43267. A system administrator can now use
> module_blacklist=tipc which would cover both built-in and loadable module
> configurations.
> 
> To address your concern regarding undefined behaviour, disabling a built-in
> driver carries the exact same dependency risks as preventing a loadable
> module from loading via the traditional blacklist. In both scenarios,
> dependent drivers will naturally fail to probe or initialise. System
> administrators who apply denylists are already expected to understand the
> hardware and software dependencies of the modules they are explicitly
> disabling.

The dependency risk is somewhat greater with built-in modules. Consider
two modules, A and B. Module A exports fun_a() that is used by module B.
fun_a() depends on state initialized in A's init function.

If both modules are loadable, then B can be inserted only after A has
been loaded successfully, that is, A is not blacklisted and its init
function completes successfully.

If A is built-in and blacklisted, nothing prevents B from calling
fun_a() and potentially encountering an undefined state.

That said, it seems the same problem can already occur today if A is
built-in and fails to initialize, since do_initcall_level() doesn't
check the return value from do_one_initcall().

> 
> I understand your hesitation regarding added complexity. However, with the
> fast-path optimisation suggested by Sami (which bypassing the scan entirely
> if the parameter is unused), the overhead is essentially zero. I believe
> bridging the logical gap between how we treat =m and =y modules is well
> worth that minimal footprint.

I see the point from a consistency perspective.

-- 
Cheers,
Petr
