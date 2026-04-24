Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6453DA7D7
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 14:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041653; cv=none; b=rfGvSfbUqY7Pz4a+vBEShrhYF2JaD/QfztuYzxV29ycetD+Di2eZa3Q1sx6QHTzGn6LcQpMY0/K0BJgjFp12A2DYO2nVTWBJBZQ5F/2ds4sSMKHShHyPA6swi6doaeY/x60+VqNMQT10cjRP6toH99z3LejUfN4fvY02yy84+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041653; c=relaxed/simple;
	bh=ssQXKcLcGAYDJ+MlHe6P5SXi6S6dHklut16i873xFNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdDxtoFK8vtmWKTDPxwOgxBAFMt56zBw7TF/CTb9dOXINDVj/l+2gKp+S7IOPxyG6xeEye2/JeQ11jKfSibvU/Q7BuXuAY//yG6Hz3msddz9D86vLRqNM4m0B0FZRe7jHYF9hNNOhOpO5a3HyWwx2X9/GCaZvj/5caO3e3TKRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=kyY1MOez; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="kyY1MOez"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-65075c2ba66so6210316d50.1
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777041651; x=1777646451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MGeb+YYn7RN3axNi7qPpfKeHmTAGHGlAbe1TFBeXhXU=;
        b=kyY1MOezylA79zBtj3kmcMYQHCmr4SI/htchkVaO2N7heXb4aSObb7WLGcZ8SfZMsV
         w//K8oEwFKmdrPlxQg/pJzYfTTMMTLPsUP56eLpDR3XydP11WnZog6MNvk0P8wdMqoR1
         fhiVhm/8bTXnpWP2X+TBy74OBsR4No92mGslWdV0enTf9i1cKleYrUlV649Hlv6KARCd
         vqvKaqYfTqZ6PAXsyD/hp7fLTu4XTS3Cay3STKyO0HZyKCWNBtWixuuLCP0IXgXE8Zaz
         BDm6rZtr2o1Q4OJMCw6sXX573tzBNDFIPoReq3qQ+BU157F0VykwFgJCPMkRkRnUPkJI
         +tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041651; x=1777646451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGeb+YYn7RN3axNi7qPpfKeHmTAGHGlAbe1TFBeXhXU=;
        b=pVqTImqUrgqeBV/lVx/mgVlpfO9bGUp0a0GhDRDQ7naC9Xd9Iwjfa6eh9XTr67hyZN
         ypRfBD/uiMV8ux9oplSXMu3bXIhyCS2tdDDfJqSMHItVuREGAuo4nYlbPK63QExMN0jL
         icpZIAsLNpv1+IwwHX1bdfkw1UGPcatlOU5pHUf8imLkLap/6n8JAKLrhz0h89pC85ki
         4s4EAd6VYpc36XeLErhOaCDMHkgT7VUs8yFiMa40p/TZbwzIEHfeLhMKxObPAYpfEMDS
         zi6WQqo/IAw5ymGKMupeSDrqYNWwGRqmPzLo4tYft2x5vpnzLXjkSHEQmUliNASfQSrC
         uJ6A==
X-Forwarded-Encrypted: i=1; AFNElJ/BLZdJOcmoMYNw8nlLtu9HAvZgPBfvEcGcwoLLyz2eLrwr0C93U3XdlDWwY+IQSbuXlVLB1LaA54ii@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ65WN6QbDGCudjKBe8YCAo/qtzFTgjVEIlzjk/jOdZ6J6TD8+
	IM/UZeXIJpWqckoL1HnU7CAGRPLQ1qXTyuPPsNLifLTq/Jo3p+mUelt+6IxHrGOFk6U=
X-Gm-Gg: AeBDievM6J1v0j2xOpR0fIcvCt8cRoYu9cZmOGeV5+34FNu0i1Rog+LQgEAAJtImJCm
	fzmVLbKulbAdgNqtzAsZfZBUuQ/K5HeniVo7u2irEt52t/HjiSzSSvVGTDrICxNNyNPI1wBwr8Y
	X+UuuVyxVNxeuJ51sHqwBv1cHszUvLNuyUgv7cWdYVMw76nS8wX1dlnwDHGGQUHDACzloZimzlW
	TCqGZDRFBz+ET+NVnYb5M+/yEE9I1ZEtUbzQ6ynGOY+HX/ZxT0mHiA6OnbFYP5ktflAyqxeDwn7
	gsYNb/DmZ2tlZ8f3HkJ+/uxeHZEyM5hD1cSgD/5mcmq1SU8E65OtGzy146qCGZftwcEj2MK+KQZ
	x4YynXCo0W6O4Sf0439txO64US6s+pHjNcWwjNxmIAr1q+TfU/eNqZ1K9bexEHD5INVox6Ti3Sx
	P2ArgY46iT4Kq8pNmKaLKEL+B6IDuHIDcMKQixUZZfp9GF1d9LP3b856ZwU/tljVrqtqOI1PPiS
	5R801Jj4NuHByyeSIslUFthayD+pDIOKMTElL5D
X-Received: by 2002:a05:690e:4004:b0:657:4568:c4c4 with SMTP id 956f58d0204a3-6574568c682mr1080804d50.18.1777041650771;
        Fri, 24 Apr 2026 07:40:50 -0700 (PDT)
Received: from google.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b25fa8sm10692424d50.1.2026.04.24.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:40:50 -0700 (PDT)
Date: Fri, 24 Apr 2026 10:40:49 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Lance Yang <lance.yang@linux.dev>, peterz@infradead.org, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, ypodemsk@redhat.com, 
	hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, jannh@google.com, 
	jgross@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	boris.ostrovsky@oracle.com, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	ioworker0@gmail.com, roman.gushchin@linux.dev
Subject: Re: [PATCH 7.2 v10 0/2] skip redundant sync IPIs when TLB flush sent
 them
Message-ID: <aeuAwkNsmDer08MD@google.com>
References: <20260424062528.71951-1-lance.yang@linux.dev>
 <20260424063024.ce42ee6a5546e4d9337dd007@linux-foundation.org>
 <aetw4aoABYj3keMh@plex>
 <20260424071533.d28ce90126f05e1c6fc1b740@linux-foundation.org>
 <80ab39c2-efb9-4a23-bd56-46d9bb4e41bb@kernel.org>
 <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424073145.b990fe9b925da304508aad71@linux-foundation.org>

On 04-24 07:31, Andrew Morton wrote:
> On Fri, 24 Apr 2026 16:20:55 +0200 "David Hildenbrand (Arm)" <david@kernel.org> wrote:
> 
> > On 4/24/26 16:15, Andrew Morton wrote:
> > > On Fri, 24 Apr 2026 13:37:04 +0000 Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > 
> > >> On 04-24 06:30, Andrew Morton wrote:
> > >>>
> > >>>
> > >>> Sashiko questions:
> > >>> 	https://sashiko.dev/#/patchset/20260424062528.71951-1-lance.yang@linux.dev
> > >>>
> > >>> (I never know if my Sashiko emails are welcome/useful.  Maybe Sashiko
> > >>> said the same stuff about v9 and it's all wrong.  But better safe than
> > >>> sorry!)
> > >>
> > >> These emails are helpful; but, I do not believe you should have to 
> > >> manually follow up with a link to every new patch series.
> > >>
> > >> Perhaps  Sashiko could automatically send a summary email in response to 
> > >> the cover letter, or provide a link once the reviews are complete. For 
> > >> the kexec ML, we opted-in with Roman to receive automated emails from 
> > >> sashiko.
> > > 
> > > Yep.  I'd be OK with an automatic reply-to-all.  Maybe some won't like
> > > that.
> > > 
> > > An alternative I've discussed with Roman is an automated
> > > reply-to-author with a cc to a dedicated list (we could use mm-commits
> > > for now).
> > > 
> > > Preferences?
> > 
> > Reply-to-author would likely be better as a first step.
> 
> Why do you think so?
> 
> Pasha, is it too early to determine how reply-to-all is working out for
> kexec?

It is too early, we have opted-in only at the end of last week.

Pasha
