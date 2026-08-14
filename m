Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2645FFAC
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786706170; cv=none; b=GKzT56F+z1FwoPWNR6Hg+S/rAdLQs6kkKPudiIDbqPURoe99vLyGScId5SBQA7OIYktlSclo53SRdDKe9FWSti1ZujtpCRaTNWLQbYs/W+uh0dGrrXhIX17o3RcBe0+HNo2uCGMCb8v4LSd8KL6sjoL4+QE7z8Ya4NJJMj2guNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786706170; c=relaxed/simple;
	bh=WC68mzM9vVdX5O4PVh43sBf4C00Yw06tw0d+DOenXm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+JFPd2TV/hvs030/vToc9E3KAVjSJjX4Rp44cwKTxBc2VzDFGkM19c3gGlDQ7gTCOc5vjL4fpoU7ozMeWCi2Ck9zMjnp33Y9SqmxznmdMJpmDMj1gG7oddFzKyglIwi7Tx7y4DquRrk/GMRDVfjia1IooyliE//0X+pha7ZBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N1OOPHyS; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N1OOPHyS"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso749056f8f.0
        for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2026 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786706163; x=1787310963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufDJ56SqV15sMOIVLhDYx7ZQ9UDhnRuzgS+xzCE8e40=;
        b=N1OOPHyS45MXH3sccBAv2rnBqRxeeTdLcQ1simpHJDu8KuFsM/QMtbqrycyltEcYqb
         9OwivpkDmJ0RtQF79WxIyobrV/6hJmlRd9HMf0+a0LrXXBhEMabsy4YcUBs/ZHZSJVZv
         eaGy3tVg0ISGERycch4cng6STN052ctq+JUSkUpQtddL+0zDtIkbSeXwwcWI+3w3tkWv
         GI3W6PBycL0xJRfXyRRrBj2T6tLjocDF0tMflPyOXoNffLZb4YovGP4FI3YMBB8Hb4En
         m+oHCeS9MamwwlKftGAJFH7eghAj6T0ZhpkY+3JYXETrQJ/RGVoOfC7d9auSTD9WPpKt
         ihUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786706163; x=1787310963;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ufDJ56SqV15sMOIVLhDYx7ZQ9UDhnRuzgS+xzCE8e40=;
        b=dgcNwHV1Eb1/VziY4LUb/gjW9QyBrBDXPie/J7NCQJ5ytrw299F22rPO6tu3XFEudN
         HSFLsVaKbfkb9hLpXL5VClkwrdUid8xIPgH/22asrb8T731vMQTalYEHSfHM4QtDaO9P
         pYT02Utu1CUXeod1fKlSB1+2/tBBQwsREpSftXGdPSaWBVV4D4rEdHCik/1Yi0NRbXZl
         N3Kym+rhD8cuOIeU0jXh8ilAHdOrQaDuOugcsdGK+ZzYXmd0fLTjDifNk2Oh1CW7PEli
         RrvPhS5KcjmjgeQcWR48cDFvU32WC1lzcEDFBNCHcYlx8YKZO8jwJZu1Pt+VMddtYe4A
         XuaA==
X-Forwarded-Encrypted: i=1; AHgh+RqUUIwU211Q9G6LFasYl/fpWQFbEm2O1Ifljbs9ME7b77IlQaXyf6cBmVLXma0guBdEPSfFnPsygutt@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXaRzSkC5fz/G11J2H2v5Jtf1h+4g7u8MqtzNXYSjf/OI7Ta+
	UbvViZrsUyByVR3FJ9BwkrVogICsHxoOflyNKUQLZxi4ocHlZbRIYraR7Tq8QPmEoxg=
X-Gm-Gg: AR+sD11yH4MmFTL3xDEFHOzAFRB4n2gOQ36C2guZJQk0XGb2CVQpiTLvwJEGNc77jCS
	CxoP/gYFn19M1IAwBkwgF7mscUAnO98LVXkQRfT1NCfVzMhdAZEwZ1KxszQrilfWiPGjp8NyyFc
	JcGS8KsTGdbREdkuwa/gFVwz+yuo/YmayCpRt7MNvnQqdi3vxsLxj2MB3oyNS2Zz+qpVjVfEHeu
	RQlrrNiaJ+SbLUPVVUn/cV8fKXwjT45Of7bKetqhEwjBqMSUpiSzMO28Z/IHvqipX/rK4xGBH85
	bixdGVe7xtc8II+0LDw8tu/KfcrHdIlp0wFa2PDyN7xpXl9+KcY5TszSWzOBgADQ4PQZEJtIzfS
	j1JiY7i63hPAsVsncAWNQH4ML7qlxS8hoHZf0XapncpBBFfaig5fLO47xYDE1bo6VuLiyElvT8O
	LC9HjgDzsJHZrnGh6X+caK25moTz3UhqTgCjck9O4KF0hCnkfzkIAkiENCp7hDkDcJEb1Dzknp6
	AJ6BfSZYlgk1zCvRsMYJAE5oA==
X-Received: by 2002:adf:ee84:0:b0:47f:eb37:fb7f with SMTP id ffacd0b85a97d-48160758e05mr5816291f8f.16.1786706163380;
        Fri, 14 Aug 2026 04:16:03 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20059asm6805179f8f.5.2026.08.14.04.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 04:16:02 -0700 (PDT)
Message-ID: <9044355d-bff2-44fa-a8e2-ee3500aa1af0@suse.com>
Date: Fri, 14 Aug 2026 13:16:01 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] module: Extend module_blacklist parameter to
 built-in modules
To: Gary Guo <gary@garyguo.net>, Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, da.gomez@kernel.org,
 samitolvanen@google.com, peterz@infradead.org, ojeda@kernel.org,
 akpm@linux-foundation.org, mhiramat@kernel.org, boqun@kernel.org,
 neelx@suse.com, da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com,
 steve@abita.co, mproche@mail.com, nick.lane@mail.com,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260807012601.360452-1-atomlin@atomlin.com>
 <DKNWEO3BOUOL.9COZBXZIGS6A@garyguo.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <DKNWEO3BOUOL.9COZBXZIGS6A@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 4:50 PM, Gary Guo wrote:
> On Fri Aug 7, 2026 at 2:25 AM BST, Aaron Tomlin wrote:
>> Currently, the "module_blacklist=" command-line parameter only applies to
>> loadable modules. If a module is built-in, the parameter is silently
>> ignored. This patch series extends the blacklisting functionality to
>> built-in modules by intercepting their initialisation routines during early
>> boot.
>>
>> Following review feedback, the implementation has been split into two
>> separate changes to decouple the introduction of the new feature from the
>> terminology renaming:
>>
>>     1.  The first patch extends the "module_blacklist=" parameter to
>>         built-in modules using the original blacklist terminology. It
>>         introduces the ".initcall.modnames" section to map initcall
>>         function pointers to their associated KBUILD_MODNAME strings
>>         (restricted only to module_init() invocations to save memory and
>>         avoid matching core kernel subsystems). It also restricts the check
>>         to a boot-time __init wrapper to eliminate Use-After-Free (UAF) and
>>         Spectre v1 vulnerability risks when loading dynamic modules at
>>         runtime, and adds a fast-path check to eliminate lookup overhead
>>         when the parameter is not in use
>>
>>     2.  The second patch renames the variables and helper functions to
>>         adopt the preferred "module_denylist=" and module_is_denylisted()
>>         terminology in the codebase. To preserve the existing user-space
>>         ABI, "module_blacklist=" is kept as a legacy alias pointing to the
>>         same module_denylist variable
>>
>> Aaron Tomlin (2):
>>   module: Extend module_blacklist parameter to built-in modules
>>   module: Rename module_blacklist to module_denylist
> 
> I feel with
> https://lore.kernel.org/driver-core/20260421-acpi_mod_name-v2-0-e73f9310dad3@sony.com/
> and this we're really making loadable module and builtin modules less different.
> 
> I wonder if we should just somewhat unify these completly, so built-in modules
> just behave identically to loadable modules, just without runtime relocations
> and ability to unload.

I can imagine this being possible and potentially useful. For instance,
a minimal `struct module` could be used for each built-in and loadable
module. For the latter, it could be then extended to something like
`struct loadable_module` containing all the fields currently needed for
loadable modules.

It could also help improve some C APIs. Functions currently cannot
determine whether a NULL value passed as a module parameter indicates an
invalid pointer or a built-in module [1].

> 
> Of course, that's quite a big change... And mostly likely people won't care
> because almost everything is built as loadable modules in distros anyway.

I agree this looks non-trivial. It would require proper investigation to
see how it might actually turn out.

[1] https://lore.kernel.org/linux-modules/610fc63b-f3dc-4824-99fd-907fc96f3194@oracle.com/

-- 
Cheers,
Petr
