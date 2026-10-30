Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339306;
	b=huk7gp7KRNJP3NEj/Ipx6FHXCYHC2mvy8EKeDraD9JX53U1lfpUjmahels3P/pTbMQD8
	 HzL9hkIQMpwhhzBEUkKEtf1MUkNwJq2V5g7ishdZZrx1w94XJhGOmxKMMHEGrDBokYkzz
	 4b7BES4vPmjp9jaVC8amgSiovPKhY2T9VghF7k8TB0/JUN9kRVFsQ3YhyVHDNhl5F/Vgr
	 8jLKeWt+EEUVuKNwi1x71jqFF3f3Dm55KdJvt7BpwnZ3ooJcnrrATTuJZ+5Szg4+sdrDn
	 7IgIDNp/nQLcj+wDSE4otP7Z0jB96CmkqsqHLpocfBqIxMUZBQpJNAk8U8BPe4vWhuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339306;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jk0rm4jvaiDVGk2youcQLM21ekVKsq8blgclz8ObRLc=;
	b=grYkPS3jOe6Qgjqh4xIMw0NLp0DiolAg9w/Xs8hAOfl2p9RS8Qj4uuwElc/Dfe9KXsYs
	 FZ/350DWNuVhTYcCEoVSeNgQQsIYnsbAGMuR7RD4dCy9dpG0skzZV6iHJu3WthzyP2drg
	 /nzjWh2uNtdpAkvAfTjgo4qCfFllALA385RuiLQm+BOPGeTvbfr0RwUGYrRs52/7BPxP8
	 7be36yK19pykiu17QJx51UYE1Mt68lQ76McgHj9SIP+Q24tzGvCYzenV+hlMz4hQ4ewAb
	 aHExov01Y+HzCviXtDrfqId4hxoMft1FyYR+jbAQH8oEFDzegvcHOnyUoxcaUwaygdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cBbaoETn;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KADzmYZ7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BEB606A31A
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 05:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5BEB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cBbaoETn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KADzmYZ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793339304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jk0rm4jvaiDVGk2youcQLM21ekVKsq8blgclz8ObRLc=;
	b=cBbaoETnikffoS1s4YDHPAXlYAu+xbNz0yi3LIeq9Y1gOaEEcewJmoZXV+GFOtTztj+dR0
	dG8/1nXuvAkoui3GxLVOpR2Nue58KWUCupn+EEtACdjv2kqz75nJl73FokrZvNpKkMStKy
	vTw5h+J9/ub6tZHcJgQPix2vHcH9Trs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-y6IpZTA-PSeT0dqwFp-lcg-1; Fri, 30 Oct 2026 01:48:21 -0400
X-MC-Unique: y6IpZTA-PSeT0dqwFp-lcg-1
X-Mimecast-MFC-AGG-ID: y6IpZTA-PSeT0dqwFp-lcg_1793339301
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1f03f2e8aso2284525e9.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 22:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793339300; x=1793944100; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jk0rm4jvaiDVGk2youcQLM21ekVKsq8blgclz8ObRLc=;
        b=KADzmYZ7ktK7ZmjSi303THK5Lh8efgG04iQ/f0kPVW5kJINAYeVlP4TZmQcpYNtgZu
         ATkT2q4dzg7SACaTFRKNQSV063REPQWM+tk6PkjUSe4rz+O3iPgRLWI0qkxVwu9hhZ7+
         MNaij1QyajYHmjoD9+ef/gDVYTf9YyUQp0+w+i059qvDiK61HwKPBRz2F5xBBpX9Jl25
         KRfr7cMM72aRRUNZpLHa+BGwV61ITu4dEJQuLdkyPfX/OxT/A8HSNO7Jx+beJvacfDe4
         asCXbx5SLUB1Wb5ddVz4sf1C0q61c7YoZLUMGYesZSFBOLVx61JqueJe01OVRDQFUWKW
         YA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793339300; x=1793944100;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jk0rm4jvaiDVGk2youcQLM21ekVKsq8blgclz8ObRLc=;
        b=HGvm9aR7pKrV5FoFEydybcMtVNCIZ37zIMI70UmwPQqOnltjFRZ7JSV05XeukHPt3D
         DHEWQsM/9NvPGGJgy3qWXGcs8YzHfdOparAA/lWNaHAWrOtMflda0Z7Pwraxf9H7Z+eC
         NSZWa8x2t/+3d03IesQpHAV4FwbNjw9sIY8D+2d17+fxwNgMYMXpKlSCQfuOgJgiYbBl
         zMZt4g5NULbLR2zjYbQ6ZCw4mWk2pi1ACLEH03xu1cPNMwY3GOrClueWYgKnhhIu8sHH
         GHK6cqj/e0g6+HdX5wr+zZGkgfq7mPgTIQIp8Uwb55J8ohCFgQAdC8tTjlBXJ7a1RoJd
         mbCw==
X-Forwarded-Encrypted: i=1; AKwUvBySIhIRV39+n8T+tmQhkgokrc6qc3qogBsNWJqBHzfxMol01Dn4jx7STz091Pt9h+luFXeeXjJqyC9I@vger.kernel.org
X-Gm-Message-State: AFq9FYKOHf1zMjW2+Qvt8mqhNqyD01tKmjE+NHRmBpTboXw8dcXCH7Qe
	NFSFg1GsG5DlVLq/80NURVZU2u8vsPhKC0+RjtB4YSv//W4JQ2NKXutJO93BzFOdV93DYLlxn1x
	2wNQsghYlRRgbiZG+7a55kisq+tkLIxM2DSzzEJ1HeelkTaUIWLilO0GgcvBKVVc=
X-Gm-Gg: AYBFou3fob/zeiz6NntKTV5FQRNCvOW33l1bDKiLCfMWQ+QZCAYVhkwPY76WBDJUv6J
	u6EellXxeuzlpJ76Iz0dto472ATT9tcIsJ1z2nSvQEwHE0u5IXY2irQ3ho9oURzdztJXA6M4pCZ
	er/8Lgyyk68yFTCu2XicTELMHoRBIDMD79e7fS89vs+pmK9MeWIo2h9+nYF5ykwVH5M7lnf9/Mm
	vUVTZm8e3hVOmJYLJpdDI6+04pUoZDwNT0cAPTp5N6NZt+KA41RR9lZ5oaDOy6km4Ifw2WXq5Gp
	rEZ0hCSuiCHcsUd7lp3yU/OLgbcKl9rZz6qpG0LR5H+rOmWj6SJKZZqULv5CJciIHlW9VXIbdft
	4qSa0zGdetO/XSLbfeY7UMzv+tNPM8r1oDDlrFA1CU4tMbMY=
X-Received: by 2002:a05:600c:354a:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4ac181e759dmr23905745e9.31.1793339300587;
        Thu, 29 Oct 2026 22:48:20 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4ac181e759dmr23905515e9.31.1793339300195;
        Thu, 29 Oct 2026 22:48:20 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d5dfsm1501346f8f.3.2026.10.29.22.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 22:48:19 -0700 (PDT)
Message-ID: <0a5de4d5-8b02-40f3-8067-f75b9f1020eb@redhat.com>
Date: Fri, 30 Oct 2026 06:48:17 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [arnd-asm-generic:asm-generic 15/15]
 /usr/aarch64-linux-gnu/include/linux/types.h:12: Error: unknown mnemonic
 `typedef' -- `typedef __signed__ __int128 __s128
 __attribute__((aligned(16)))'
To: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
References: <202610291918.kHO0GTDB-lkp@intel.com>
 <9e294bfd-4704-42a5-a704-f301f4afe042@app.fastmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <9e294bfd-4704-42a5-a704-f301f4afe042@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/10/2026 23.13, Arnd Bergmann wrote:
> On Thu, Oct 29, 2026, at 19:09, kernel test robot wrote:
>> tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>> asm-generic
>> head:   dd7cc8c26b6a37a54adc5ce38d286521b7201044
>> commit: dd7cc8c26b6a37a54adc5ce38d286521b7201044 [15/15] treewide: Stop
>> defining __ASSEMBLY__ for assembler files
> 
> Hi Thomas,
> 
>> config: arm64-allnoconfig-bpf
>> (https://download.01.org/0day-ci/archive/20261029/202610291918.kHO0GTDB-lkp@intel.com/config)
>> compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
>> reproduce (this is a W=1 build):
>> (https://download.01.org/0day-ci/archive/20261029/202610291918.kHO0GTDB-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes:
>> https://lore.kernel.org/oe-kbuild-all/202610291918.kHO0GTDB-lkp@intel.com/
>>
>> Note: the arnd-asm-generic/asm-generic HEAD
>> dd7cc8c26b6a37a54adc5ce38d286521b7201044 builds fine.
>>        It only hurts bisectability.
>>
>> All errors (new ones prefixed by >>):
>>
>>     /usr/aarch64-linux-gnu/include/asm-generic/int-ll64.h: Assembler messages:
>>>> /usr/aarch64-linux-gnu/include/asm-generic/int-ll64.h:20: Error: unknown mnemonic `typedef' -- `typedef __signed__ char __s8'
>>>> /usr/aarch64-linux-gnu/include/asm-generic/int-ll64.h:21: Error: unknown mnemonic `typedef' -- `typedef unsigned char __u8'
> 
> 
>  From what I can tell, this happens after your last patch when cross-compiling
> kselftest against system headers that still check for __ASSEMBLY__ instead of
> __ASSEMBLER__.
D'oh! Could you please drop that last patch for now 'til I figured out a 
solution for that mess...?

  Thanks,
   Thomas

