Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B483C3BFA
	for <linux-arch@vger.kernel.org>; Tue, 26 May 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778394; cv=none; b=uovIOhVVxL8ATEaHGxU5FFyal+yPVMNu/LlFOAvZJ4PGKcWIaEk1kKKTzAzdgUonnz5Gdz91KsVo/Vyl4hteEKd4v5DlzJf02xMuerPWHTMAHBtrrR5Tw+0hxutbsHD6gvr/xoX3Ag++Nfm30fir+xsbxKrOH6R6B+GF4B6YH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778394; c=relaxed/simple;
	bh=lI94k3K5Kcc20pekEfGAOaAomJ1QgkYtP6G74MUe9gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlMMXgdXAIflrYZOpk0qlh13zPfPAx9zc/J0435IU5r3QSS6GNw82craNubKQNa7dBcIiI12eVgj/1JGk2quup+W+m3aTDDcjTtMCIb6o7jzuXb7HWtQl6edBkVQ7n+znZrSTSZEQKuTEYE+Eo34l+h60yHtwM2RJ0YfQrVkBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TR/s+dSF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TR/s+dSF"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ea19f412aso2824951f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 23:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779778389; x=1780383189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=TR/s+dSFI2Vk05JY9oKvhTkUPLyGjERphtpAPMGuiQxvuv3fbFSbN1th4lK+bttysm
         cFb/iWCpkNb08kRUbTcn9WjfJUaB3xcjwa8CXEuHNu8ztYYWGwWQbD8loHo0HuyuciOC
         0TwcL+CxgU01vXU93n3aCg4f5dmgC1/3cis8o9d493p1B0tb+ArlTCB5LaW6RVOHuZSe
         xFgNBY2Ddet/gPdHUxjFVULwbZSkZetwjzSKlyv7KFRavsith7RHUAc5uHnKUJqDu/G4
         H3+i6q7GH893mbCE8FjnHXqiv6/6t+5ocWoYo60XT6575r8A+rywJ8KG4tumaLrCo8Ff
         W8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779778389; x=1780383189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXWASYjT/jE4WzpKhE8nVhHkzGwmPlTITkkcMF0D8BI=;
        b=Wm+Ua7FNwa53qcigYZH9yjKYJyfF97zGfZtMbwg+2kUetoysAelvgpGlpxf6LTE1i/
         LZPLpMa7WKowWmI8CKueZdA3ByLYp+AyBvVb+xxDA8EboV8kc3kDmFTruY/1KcuHIUit
         I9efN1xAox3kYxJ1THoMBKkThrJK+bh3jmbOTTxOzI/q8QF0kTYtsmKsJHmgknVLZ3zg
         yVLEyt6sRxPKd0soUC633Bf7teQ5YYLdXqUAVLHNgZrTMoqE5O9ZKW6rf1BkOt6XhX8H
         E+UTVZviwgJhM/1gAK5LkFxkgWXB/9jcFLAcMlsva2/NPwdC1iRIwOYC9U05g0uXfJdC
         ECNg==
X-Forwarded-Encrypted: i=1; AFNElJ9NbmqHDjnmn9YBbWYp9q66bIxSMU9hpoov2NUAdIdi6wLG5tIOpk7S8A5LA60H43rU7TIBGxDKCi6q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+P8ch5gJyF0Ub/BekGYeMuEcfq/G62un+gH+BgR0bpXvsuQiG
	yem/vmD3ddaAOgeav0LbnyL2RWoexoz0hwaO899/5pmiwg/RrA7ZDRwjzDKUN7wQRaE=
X-Gm-Gg: Acq92OEPuK5VZpZ2zZdNJkTK/VKT2xIcOTnPESEeAWr10/qNom+x85ViGtwhNgh/SBK
	rcPcB2yA9COQPfWG+D3AfBJm56ZWFnSGHvZBEWUjjaajprp5x/+qyPjK4CNfhAY7JOoWK95DP3g
	7e20vJ35c615ltZjMp1sjvL42j6DsNa2JNoXgZRK04vBZTtAZbqTkicK2XXJeF3o0PejoyzODyA
	hPjFUg29dFT4AmXqJ5TLoC9LSZPijyy6hHWKf/e0hs9n5cCW669/YWTnOeZpCFCV2nbZL22/N3t
	XCW5PMq12LD1TY7gX1TKA7Aci93xD74TRybUL7JycO3MdYiJd8+qlWjjX9ILc3t3DNTrGk9DOiz
	P3z93qekTsDUu4sU7Pc5+QwMBpnt+TtoNFZvzNklUJRctdMHrNkb2jWCTwsfGV0zbo2iArZYlvC
	Bmsb9IQcwtW/aRo1ih1WUAock5YTyg5BCORch5MsInUMY3GJrxD9dqA/x944uJ0edfjUZ3wC/WK
	zzR8qogruX0uo/TY65Y64C11WsLbHE7D6/1dX/kjQtakLvHGu19+IURC9HcUnCvXBVCFPtaQqnp
	fthH
X-Received: by 2002:a05:6000:2003:b0:43b:4136:1e6f with SMTP id ffacd0b85a97d-45eb38e4b46mr29516257f8f.38.1779778389230;
        Mon, 25 May 2026 23:53:09 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm33848641f8f.8.2026.05.25.23.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 23:53:08 -0700 (PDT)
Message-ID: <88c5ca1d-eeda-4023-bc7a-397b92780db9@suse.com>
Date: Tue, 26 May 2026 08:53:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Convert moduleparams to seq_buf
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Hi,
> 
> I tried to trim the CC list here, but it's still pretty huge...
> 
> We've had a long-standing issue with "write to a string pointer" callbacks
> that don't bounds check the destination (and for which the bounds is
> also not part of the callback prototype, even if it is "known" to be
> PAGE_SIZE, which sysfs_emit() depends on). Both moduleparams and sysfs
> use this pattern. As a first step, and to test the migration method,
> migrate moduleparams first.
> 
> There are 2 "mechanical" treewide patches that are handled by Coccinelle:
> - treewide: Convert struct kernel_param_ops initializers to DEFINE_KERNEL_PARAM_OPS
> - treewide: Convert custom kernel_param_ops .get callbacks to seq_buf via cocci
> 
> The last treewide patch is manual, and may need to be broken up into
> per-subsystem patches, though I'd prefer to avoid this, as it would
> extend the migration from 1 relase to at least 2 releases. (1 to
> release the migration infrastructure, then 1 release to collect all the
> subsystem changes, and possibly 1 more release to remove the migration
> infrastructure.)
> 
> Thoughts, questions?

This looks reasonable to me. I added a few minor comments on the patches
but they already look solid.

-- 
Thanks,
Petr
