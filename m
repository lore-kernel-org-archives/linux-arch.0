Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD873D47DC
	for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442973; cv=none; b=vBu0eb8XF0PAQNHmvPQc7w98Pi2/hvT0NsTo4ce4AqQ5J5CrOitCqm9BAjeCzWF6bkJ7s9bB7q8K1lK8v8mzeQb02T4wSrHXveq23EkmNeCikeG2DrVY/fYGn1xe/0dCpGWDqkvNq5QBlUNxObXH7XPO7JHulVzpgyJeuzhC+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442973; c=relaxed/simple;
	bh=0jbWB3FjVQp+P8Ybiw1JdATIo1RfpVsEkcvfvEH0fIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdi9rQmP6okhycaXqcUbZH5UM6K9DS46djxiqaf120pdKnbaeHnCfj2OO90B+a+Na2UQ1e28fLpwEtsbDgJp/p+eEUvHAva/0MgzQj5SwwOtymEFwcFsLa0chVVQlQKAZi9gq9Sa25/KPL17QSjxymsBnbDiNA7HmNrSR7jSD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QsQTBQ2R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QsQTBQ2R"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b6d9c981so609326f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Mar 2026 05:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774442970; x=1775047770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ4RwDdYC7l5LX4+kxPiqchKwdT0zRAfuYVx8dHTGTI=;
        b=QsQTBQ2RkrQE7IMnUQFMVZf91MzfH5VhYOdj1f6Kc0qHkUjbpodcFhfNqvP7j00lIL
         7+0NS3ce2sJFLeV0zP1vFfjxIhzEfBOaUThEj56njyTJBz08hVYC3GsWPreyMX0/s+SI
         bqiSjb8e/MteSBDYDfZ88BtS+5N4oP3+lCjFDol0aDha2po5mM/macY7Gqc9+Qj7BF1Q
         Q9kC8G6jUxbYVPT/E3pXanzVD1QenpTOeoh5HahyBpCrlKLC34dPfa3dBGd4ozO0YZsi
         7nw+Vgi2bbhvnadrOePJ2jhdU86tkN+eJJiNDLdUr890bBTyvTbkDcI5FEOSvJZkri2v
         oHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774442970; x=1775047770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJ4RwDdYC7l5LX4+kxPiqchKwdT0zRAfuYVx8dHTGTI=;
        b=Xjwz+GoCxiZZ18H2A8LUJFPuVhljwVGnywh4Xc8S7Hz1+3522kkkYUvNZqR6UFlpPr
         t5aEoYk4op8ww1ZuVD/Y0Sr2YIgXHvP9atTKLUYnEaoJF4tO7SGokkoWbReOWzz+h9TP
         xJQcjYB91tlEuX5MBalEuMaoArufQLJJeQovpSLM9n/DEiriKckM5awV+xzHQaJ152+y
         XISKg0LeinymGQu8gmnF1PDjPA+YjieUOyvanguCGyPGyoc9eA4kNMB7YTCRG/qp6FUt
         HUVDpZTt9mI/Fyw6joPdgThE/KOEFoZF4w0PtZVuOctvyFcmxuMRAFAPrpUF4xt14vf8
         5BWA==
X-Forwarded-Encrypted: i=1; AJvYcCUGfCN6EUv+YiFWuJAfpB/eOtgrstB6jdUIuTrnKZJtTaN4D0nKx9ayAwYKprqcB08L3k1P9z+7Ivu9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0vA4RJKaIPo9RX0H26dUQbNd0oa/KpvritE69TEE2US9aR1z
	6zHN4qGABn8O9Aq/XUDPp1RWH/24dzb6fs/ZRoEw4oAtHmTTa8m/3hrkskdYqzQRWWE=
X-Gm-Gg: ATEYQzyeeFS2J+tnR8rmBLhJc7EL2x/ouBN4cvf7UZSdXYv/2I5r4NZ5ENx2tP1WzVK
	f0AmoGFIKj+VwEPc5kjrCu3seHokVgLFyc6IbQ8u14Sk5HAuJ4nu7NbIZdh8foRV4urxMB2nZ1+
	ZnaSB690sjXmdjv2+6gW8i3dLpFT4HCBxB6CfZJ5KJqOA092h7PP5izXlVqrVs4zBSTAylgKHym
	WMrcRWTBFmE/NCBiL1PcqDxSMHP8BZ4c2OeFyCjpM9QYqNvLNV5ieb1eoBu9Itcyd/bqk6u1F+X
	d1TvG+1xt3zVEuDhP/gAi6r2DjXY+EcUsxoAX4sXtPeeo+xwyjhNF+uyDwUg1+djDuv60c5FZ2Q
	k+OBctOkb0OQebQSn7jm6KzKkXyB2Z7hk1/iOJOAQuhVWSwDF2/3H6o0GYJAlWZdzoAYZ7vxHzz
	AwuAlE8CETmEZf9EGaVZ52O7k0WboGAPsKJN2L5Szauayy
X-Received: by 2002:a05:6000:228a:b0:43b:4909:203c with SMTP id ffacd0b85a97d-43b883c881dmr5791312f8f.21.1774442970332;
        Wed, 25 Mar 2026 05:49:30 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b8508285esm13445921f8f.19.2026.03.25.05.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 05:49:30 -0700 (PDT)
Message-ID: <b83c9524-13df-47dd-a597-bebab93288d8@suse.com>
Date: Wed, 25 Mar 2026 13:49:29 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] scalable symbol flags with __kflagstab
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
 maennich@google.com, gprocida@google.com
References: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260305-kflagstab-v4-0-6a76bf8b83c7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/26 5:55 PM, Siddharth Nayyar wrote:
> This patch series implements a mechanism for scalable exported symbol
> flags using a separate section called __kflagstab. The series introduces
> __kflagstab support, removes *_gpl sections in favor of a GPL flag,
> simplifies symbol resolution during module loading.

I noticed that the series has a bisecting issue. The module loader
doesn't see any GPL-only exports after patch #4. I think you'll need to
squash patches #4 and #5 to fix this. Alternatively, the patches could
be swapped, with the caveat that GPL-only symbols would lose their GPL
property for one commit.

Nit: Please use simply the "module" prefix in commit subjects:

#1: module: define ksym_flags enumeration to represent kernel symbol flags
#2: module: add kflagstab section to vmlinux and modules
#4: module: use kflagstab instead of *_gpl sections
#6: module: deprecate usage of *_gpl sections
#7: module: remove *_gpl sections from vmlinux and modules

The changes look otherwise ok to me. With the above fixed, feel free to
add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
