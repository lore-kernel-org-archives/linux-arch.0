Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13F8481233
	for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328492; cv=none; b=bOQvR99EPZ+WZghOUyr2BcAqQS6gicjLytDop7KnNZahNuRaqsh62LSMcZLGRVukLssdc53LLaDgs4gcrtH108TPk7yvxTlcuZ2qDF04BhLGLun02wXl+vMUgqg0nKvz9cJCqMljoFSyvNIpjDMJjqE2stKyKldyJGdalm9xz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328492; c=relaxed/simple;
	bh=RyhPOU+vvqd3rl1UlRjckMuKAfbjLaCIW52sS+yfk0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ag7AHQe9+M25v6N0Y1ieoP5mLNz+iDaJuaN3bfdZynyXFKzDfSB/ZDO+pOcZ+ALI8YFSsJlppN11QORTTbpojVnmPPky/5KkB+GZtda5ZLgWeIt2tBKBFAnAiSMt3hMWeFIv+Qwo6T6UDYSVSXDe3tWQIh6hpeHSncBkJGpUMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YCaa5B8/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YCaa5B8/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e66390995so3959665e9.2
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790328488; x=1790933288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GuAasn6M17RraKJz85D0VGepUYYLmKKd6LjzFHjVWiA=;
        b=YCaa5B8/bbraaj9MXbfcKga+R1L3Oy53Dlm+QLJ9PluOw2HJuSZ4RD0OUgpEKjEDys
         1iIjGIzlaLXJl+fJzhD4jsJKpX5ftjb/LWFjKjNSvN0uwzojBFSmYZYw1vDOyCInGbUe
         d5kHIKVqyg3wLnQ6C0VSNz7g/+iaP/c5K3E5bSPY0TEFeHNVg4IhHe4Q2p8E6MzsC8dT
         n8na7+M39OVdS6Nak1AG1EpnfI6rPQBVhwmwML6M8v349eGyR3HHS2N8OshqSNp6V+WE
         IUEAemD4YTNyORvF5Su0LA+6HBShR5Rw8n06UjjwBYuJSJyZ6FP2VmqYggRcG9WSYKNN
         nCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790328488; x=1790933288;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GuAasn6M17RraKJz85D0VGepUYYLmKKd6LjzFHjVWiA=;
        b=o+q4ga8WcZxpVmSIHtchBrdAzu3fsi83Gi1UfQZM541aOZJYHOgijEcgeESMl1SZkX
         HIHSC/ueXkn0vHmPg9DMUqK3eYI7HeZUanNjNDYDSAuqAVEY+ebLWiGN6ZyAOzUtqh60
         D1v3ISyNO7DudPJ0T+DPHPH/DZi2nTfJZI9pW5CV7/gHkVVH3TLr/1EdyoBdxx6bZKDk
         hFNJ6jiKD1iirMeFCvBar2xB1sWMRXqrwpEm0D2wEyhDyykJzGgkkFnpYAfyNjzeS8bb
         G5UVG+8NKg3dje8WApSD9IuEpXe1oNPBAPWCPftm6vlrZXTlV094L114HOyEZPneSCys
         w6aQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4Yf3Uk8/F34wyIWNoM/+rgbXkMS6xLG7MzIAno6xu8ZG61mgfKOJmL7kiviDT26yTNfKFmtxQA0/a@vger.kernel.org
X-Gm-Message-State: AFuF++mAfMo+eu4NGtA5xSjWke73pcFEr+gNdSddMgjvmT9AVtfC8kfl
	JxJGu/U9WfrQ1kukUESSh0BnI4VNMs978D16AtrzZ592qRi9uC87V8llHDD2YCkGejY=
X-Gm-Gg: AYBFou1ZzgFp0VeMrev/GUzV4QQpZOuAiG+rkeJcWMw8tTljvGvNCYzxgGtZmJUMeI1
	lfPMc4/HJSlBZU3s+YxWlQZTIFi8TdOHNiXnZOFCk7Eq9r4Cf2vw3OjbB8+rI1/ieLrLebdagB2
	Tysgs4uyk5H11IGUWfEmApnOrZ91Tx5KjRr7h5m83ukaezfTnn6PAMc1NvSEaM8Qcnq0WVm1Je8
	7RN30TJdZKo7N6zDL/74B9e6h2UREPSzS0s3t1f/myFPkpmpzRNClb2YkU0GjMrjS4LtZ1Snm79
	Mt6KPIKU74rpu8eGS18UGMv6tI+9/72yT229Y0hMvKyp8/xedtn7QaLPpT5I7IEiTfIb8+7kurP
	mycWtm2R8SLDTqnZm/Z1H7IIhT++pwPJKXEq/AnqckhfnAyQhYNm5LnC+VWXGlFSCbjDiU6rBJa
	AN0EvpkAne823SMqEB8IMKRO2d158LkpFwPeU2xM2L/7VpE2LTLBDQmgoNSyqsmoi0J+KR2z5eK
	WDL3zc0SaFpScDweB0rg0magLUbxJn42MjYZ3XV6Zpuhg==
X-Received: by 2002:a05:600c:19cd:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-49ff06f7a45mr28683465e9.30.1790328488006;
        Fri, 25 Sep 2026 02:28:08 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fee6ced69sm37140085e9.0.2026.09.25.02.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:28:07 -0700 (PDT)
Message-ID: <f1d25d13-4adb-428a-805d-d3e19cf1013b@suse.com>
Date: Fri, 25 Sep 2026 11:28:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 20/38] dyndbg,module: make proper substructs in
 _ddebug_info
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org,
 Louis Chauvet <louis.chauvet@bootlin.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-20-9b6c217fdf2f@gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-20-9b6c217fdf2f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 12:34 AM, Jim Cromie wrote:
> recompose struct _ddebug_info, inserting proper sub-structs.
> 
> The struct _ddebug_info has 2 pairs of _vec, num_##_vec fields, for
> descs and classes respectively.  for_subvec() makes walking these
> vectors less cumbersome, now lets move those field pairs into their
> own "vec" structs: _ddebug_descs & _ddebug_class_maps, and re-compose
> struct _ddebug_info to contain them cleanly.  This also lets us get
> rid of for_subvec()'s num_##_vec paste-up.
> 
> Also recompose struct ddebug_table to contain a _ddebug_info.  This
> reinforces _ddebug_info's use as a cursor into relevant data for a
> builtin module, and access to the full _ddebug state for modules.
> 
> NOTES:
> 
> rename section:__dyndbg_classes to _class_maps, to better align with
> struct _ddebug_class_maps.
> 
> names together, for more obvious name pairing.
> 
> Invariant: These vectors ref a contiguous subrange of __section memory
> in builtin/DATA or in loadable modules via mod->dyndbg_info; with
> guaranteed life-time for us.
> 
> struct module contains a _ddebug_info field and module/main.c sets it
> up, so that gets adjusted rather obviously.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
> v8: set maps.len = nc unconditionally
> v3: squash in section name changes.
> 
> v2:
> 
> Move RvB after SoB
> In structs _ddebug_descs & _ddebug_class_maps, change int length to unsigned int
> No use of <0 vals is contemplated.
> 
> dyndbg: improve section names
> 
> change __dyndbg to __dyndbg_descs
> change __dyndbg_classes to __dyndbg_class_maps
> 
> this sets up for adding __dyndbg_class_users
> 
> fixup-drmprint
> ---
>  include/asm-generic/dyndbg.lds.h |  14 +++---
>  include/linux/dynamic_debug.h    |  34 ++++++++-----
>  kernel/module/main.c             |  12 ++---
>  lib/dynamic_debug.c              | 101 +++++++++++++++++++--------------------
>  4 files changed, 86 insertions(+), 75 deletions(-)

Acked-by: Petr Pavlu <petr.pavlu@suse.com> # modules

-- Petr
