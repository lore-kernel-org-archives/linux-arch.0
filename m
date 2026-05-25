Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8C3195F0
	for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725967; cv=none; b=Yt2AqDS4Zn0WZhiVBlsCBRRMW6RIuzP0d406Nz0MWgTIQwnKEyFFiNx3EHBDGvgmN+iT8W7fOd1LoXM+hP2gGZ6zePfBGSFpB1jRdul7+GPjPF11+e27hr37/jeKcFvfQqHpN7fYPqdwiysJIb8RMUjoQ/Teu6NQB7aMMELqITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725967; c=relaxed/simple;
	bh=6ATTepTt/W1eTfJKlZcOEC7miXlLa4M2ScAL84EJqWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYuLStkIjEFCKhK8F36TcVAe3D+WK8KIGco/cVsB8AvSGfhUURYfiaDqtvYw9U4yGoZMLzFVkDpNNmfR5WoOtQT5hvNT7A6nzFFmMuPXA9J1Oty22T3KLyrBW1LA/slLkG9Pj3rCMpSjgJzZ7kxYv/2Xzr4da0kcFM1xJOxyHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dr4TZWgD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dr4TZWgD"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48fde648a71so63301415e9.0
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779725963; x=1780330763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
        b=dr4TZWgD1Esm3Qat2phkFsMogL1QSisy0KS5zRNj7QLd+O/GTWfZKF/uEdi+t9nmcR
         dNii4QQxToJf+zI9chidglTAOXLiVdJ387YJpWnu4O63RZWZpdft6OjU//0zfSVBO/Yy
         aLoJ+GdqYyIcf1QZ3S/llKFAOlJ84UyYM98oHjPHgYY3F7FL0OrljqOzg8++8jmqQw7A
         O5n5KKQspBxCRl24VEYndxfcbPND9j7SmWztWHYdSuVM/njdzkK1jbGeu/q+wYu+k1tw
         8TTcdzkzuBj6AUmwdDxqdavz+slVMsWbwdX+qKe1b1YYNz7v1oMCb8aIIpb7FBEk2qd1
         WQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779725963; x=1780330763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YA+/JJXQ9abERc/NViF0XyaL5qdJ2pUb4chRkVwshY=;
        b=rImHddTgKo5iA7mJfI9O4uQZESI6uIXJIhgLJc4WSIWlCshjP8XvlT7+M979V63oYH
         MhWxCznjIoL5JXQDLWb5HmLv1jqdzmg3VaNokiTvXu30UJKMhC2Niz9zjHl+Dvw9Une8
         Y2thUOiF8UGnKjVtZcPEVYY93gizLISpXZlKrpYNg74Yk+moA6UG1X3ez7gKm6zuXfx8
         xBVcMX9au7Q3PKzTL+H9dJZ3OeBwxIr3Y7ULz90CZLM3PKqUoDu/ltQ2eW18zka4Adsc
         SGkXmaEhBL1J2zNHldZcExhlykFTTfY35S53+FbEV65I57hzSnaZt/iaPdfRnyQV/RJd
         9d/w==
X-Forwarded-Encrypted: i=1; AFNElJ/toqAYJDcdN47sKtBNbILlQ6x7GwUTsAUsp6Xapwphv7jQed2sxTgPlUEQz0NGgVhPKsiNKajr+TJc@vger.kernel.org
X-Gm-Message-State: AOJu0YxYNcVBfPcBoMRSQ0OyWBiURisawg+cGNdCyOUESXatJn0q7NaN
	9I0h+RVTs/pxv3Rpv0XZpOhbF03qo38HzhxsE3AuNUbrvTNH4ztF80FK58eeYgjCRTU=
X-Gm-Gg: Acq92OGUfi5+2QSBR+kDJ0Ky8Hm7cr5xuYD0KKejJuJywsjwp880+UjtxgbsLIRhlw0
	s80gvM01tVKFiZIn9Ur95K2wo0l0luxDBUGuOXcmPLla8i8HeRcKalIbkFHQWxqhXkFvND0I7rk
	4/j8uMX4OrJctWZo6+KVds/n9C64nD/W+nomrWHZNZ3fW0FYLg0W7AzNkr7W7oqqeq5mz7eNKDs
	ingmYGUHCR6lm516MP/hKxsG/H+SVKhx0cmLQUR0mr4pU03tsxAYsqc8/TD0x8Nm2QHTWWtGF3N
	XQhJTWfGk7+IJnOrcB+la7oEEQespBGp4oM5nlwrz4baRYDPEd6eaVRXUwZm2TBfFK3VIXxNP4p
	NdmGXnopvt6IZnpicpKDCcgvPCgNtDgvoDAtIPUmNFeAo5PDLsklR5CPnOBdbytzCvBA8J8t/65
	oPWN6G5YYjHkY02j3bAmfhGrY/XDBkEP5dy8SBv+fc8fLa3xS1gXLLkvNt1nyAM3qOQM0ZX0mSV
	l/jUXDMDX6lqXot33XmkC7pHQ9h211+vHvN7Lvm7H6KS9T/lNx1XebhLcOQDKxON3tQhA==
X-Received: by 2002:a05:600c:3b07:b0:490:f7c:b19 with SMTP id 5b1f17b1804b1-490420f67f5mr197977845e9.0.1779725963153;
        Mon, 25 May 2026 09:19:23 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059cc9a91sm48939425e9.1.2026.05.25.09.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:19:22 -0700 (PDT)
Message-ID: <a4c7ccee-6189-4c74-bad8-57d1438c7d8d@suse.com>
Date: Mon, 25 May 2026 18:19:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] moduleparam: Add seq_buf-based .get callback
 alongside .get_str
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
 <20260521133326.2465264-6-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-6-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Add a new struct kernel_param_ops::get callback whose signature
> takes a struct seq_buf instead of a raw char buffer:
> 
>   int (*get)(struct seq_buf *sb, const struct kernel_param *kp);
> 
> The previously-legacy .get field is now .get_str (char *buffer);
> .get is the new seq_buf-aware form.  param_attr_show() prefers .get
> when set, otherwise falls back to .get_str.  WARN_ON_ONCE() if both
> are set.  Return contract for .get:
> 
>   < 0 : errno propagated to userspace; seq_buf contents discarded
>   = 0 : success; length derived from seq_buf_used()
>   > 0 : forbidden; the dispatcher WARN_ON_ONCE()s and treats as 0
> 
> The default policy on seq_buf_has_overflowed() is silent truncation,
> matching scnprintf()/sysfs_emit() behaviour.  Callbacks that want a
> specific overflow errno can check seq_buf_has_overflowed() and
> return their preferred error.
> 
> No callbacks use .get yet; the legacy path is still the only one in use
> after this commit. A subsequent commit teaches DEFINE_KERNEL_PARAM_OPS
> to route initializers by type.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
