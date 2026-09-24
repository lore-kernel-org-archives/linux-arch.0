Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA245DF77
	for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267895; cv=none; b=WSYgOIxnL1bUTcNnR/stiRreT0YJTdf1khdB5jqQ99AucEuikY+/6ahcF2uYdle1/eyN/HuG1t4zMJXK2LSAfaeM0C1RcgeEU9oINGOwXbIdjiOLXmwU7x2B8oqKJ8pbdLTKKsExiPyrTp+GUDiaVdr1eoskz9P9uEhvKqwWWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267895; c=relaxed/simple;
	bh=Y6dfgoDu9ENyHz35342iESy0PYqePxl/sIn9jSurkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JG6ZzNHm5zW1jgrquJE3ip6+u6Fl87Pcms7URa7RnRqDmby87opdW+fnXW5hzmzT3DUQO+XeEdRGFmB5CID5EZFk4OQfqlpqVw7Fn3nvNnWLJyhOhsgp/0cKWdWxNRPdpBqOL40gQ+JB9SQ42+vuu6x7+tgw5rg3onkwSPczeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DELaQ6H+; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DELaQ6H+"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532e91a3687so105081cf.1
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267891; x=1790872691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=DELaQ6H+GoqYKhSPbbw83I2UghjOPLUKt/HJzwYXOl5vd4By1b/ewKsZIbd9ahXhZb
         TJDLBT2drAnq8j1D4gtZjKdZE54vfhHIW07z7SMjyhNrpJZ88lIXL27llafwJKgt7Hvw
         zeqWn52o1fsiwmzoo4rrDQZv3h3IiFJnFO2iuBnkUsGA3ktjvtFHA3Jr6K2ZEcGMg8M1
         1di2ZTIAJ2yTB2V6zmlctv6zG6tcG5IvMF9RkWmI06r7tX+skZxDuVThBB0MSr3NZe3S
         B2+XxiOTA95Xk/3/+mlBZ2rpvQSIcAx9lD43yFxhcrOBvTesr5mE416XkZK5Fw1vsdLx
         5Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267891; x=1790872691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=JrcTH5MeWI2CqHCNKr3XWSaokW8e2Ny9N+9OyNcSjaP8t/CqgrWn+hoS4z50nbQjh2
         r4FvG7jl+ow2xDaq4HujuWBdAyZGh8/uiqodVC9fOsVpC0D1qB10MABah/WpGeswT9bR
         PUvaVTWoGtk8etcwU+apV0BQ7GxOEn0ERNugpTX66gsmrE/LRQlmg348DzAt1VNfkNbO
         U6LTUWE0EklJOkt4X3DsXCptzW/cc+Tt3A4wm47w0VTPIblSsMSk0B/aXRQEyjC2Eme7
         hP27zIeKSxjMV79QybJA3LScbhmuglYOGOUGZUIYTi3pdOL/Katu4yCyzlcaQSAEWf9j
         j4Ig==
X-Forwarded-Encrypted: i=1; AKwUvByF6Exk3AjONXzVDY1NLyreUoXFxw7Htl1liRuywJXc+FneoPkdeWJ9spCfPKlpHo5nRs1uX0g3vqwU@vger.kernel.org
X-Gm-Message-State: AFuF++noqLCvFyK6q11P0gvhiNUPsw1Me8H/xVhBfOWhmiri8XTJ3Lji
	nRhMIsVL1nloZ94I/jWWKynrKBljlEvYqAkCpVdZ090DLXf3u7yxayGDhvuwA1sn6WU=
X-Gm-Gg: AYBFou3YKMZPo/HINVeu4C/LGXq9Jb0A7BYVxDYlOnSFqRDORZNEzDn8g6miThNsBOA
	WhF5rkuwSB8yHcrS26AQ0Buez0Zbo6FGC16GpLWPBp26wdQZLyUsu0tc4aj2bDYaJABpU79sErV
	/aZPifvHjNdL6902Jcm0kSuI+PU3JbWlZPUjUreDltBLfxAY6arVGKW5vydWLvR3enzPvU4Rdik
	LLyAGVbkAKtH0gSbub1uwt2worgp2SbE3NoJAz7/7vqSw07gMLA8FR+6ydwcFR5/5arZeywqsNy
	K5urp44xLqyi9lJ2iffvxP/REC72E7H+hNOARGmg8aNycN2Dgn+mXFs9GOIEDYvGanKYLd6WGoy
	x/3cwxLVJKBt40yfK1FGV/E+k9FvrXUatcOb5KQWStLRSqrNQUU/EhMbAUPK/GWrLfNIIQiJcDF
	2E4gAVxmyDcCeVtgJdunQLquRCzd55STkzCGTB0hmsQMEPKm+6+n6ZS2ASjU8NpCpirVMBNia1/
	91anqUht6DjveJRUIYWTbj+9y4wQtbPQzXTupIK/O6o3oWqVU3GyDY=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993;
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use
 vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

