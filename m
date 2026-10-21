Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623741;
	b=t46Qn+PZOka/erWkvnKeGZSkMJwvtz9Ued+nweigmorySccasXI7cAOKGNM0o+1vavQG
	 rPQl1UTZGe43oeKokziypHRtdxPbQiHJyE4eaKSRJ9mUCRpP3GLdWT1gaem0lTVGI8KQb
	 qlg8JwOgmClS73wSk6eL6KxUXW9ohnTOxQgqupbTflZtFFXEenSt9F8lBtBZYVHwp8Ird
	 0KqZJFlaKwXlDF945x6u8A8liiZW5lQleoWcNiVSBVZdY0MnfCAsO8nE7NIK+NuJOV2er
	 kAMyhn24OOGiZDa5tT52gsTcK0wy2u+MBFygqidamlyJANJtDU2qi5Kno3clCISRQcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=Rh1ct0ynFCJmpIeBgUsQvZu9SOoIsv6E2A9BdvVwioc=;
	b=VO+HqCLBB/c8pE2MH7JHTnv/fEJg+VMoau9Nt3XHKBrJW0SAAHCsWSFJUAImeIaYfWge
	 J26vW+gGc0qeK/o6q6y+MAnoDBTjLY/B8pcEZGQv4DV7726bZrqc2PG1z58MBtma8yvWT
	 fqvFtdTGYPsUiStsdb6K1oHiSeEtZbFJLJ9UhSwU7gPXYcHy0sqRm09/9l3j1D8w1pGLs
	 RTMfZKtUghLi/ZhB7j0QVWm05KS1mEHaIen6sPY4tZ2qJ53yKXNrAeb4q238xeBXoqV91
	 D8A1uMqsw9vOKCqwAhKr+iS6yt5oPZRV4fQl4y4dOK/DvOkYmlByZa2e72WFdMw1Lzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gz4UAPgW;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E077606A31F
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 23:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E077606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Gz4UAPgW
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so725526a91.1
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 16:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792623740; x=1793228540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rh1ct0ynFCJmpIeBgUsQvZu9SOoIsv6E2A9BdvVwioc=;
        b=Gz4UAPgW8JCrFaLwd83C+NYLWBh7WrVeAbPCKceaugzzPgdHzZFvs8xQ6P/pBp/GFn
         kNfUOGF2clZnhpB6j0JG8SCjgqZVXBLcBt3zjTlthbSSJqXFq6YSQPByfgyeRZOMqGqY
         gFdiOi9nkyHnv7/S3ROeTwkHOkKFreTBDdA1soan8c5QpUTRCqhdn5fOHAdholqli5V3
         I9GKiTsc4yn/PjkjUPmdhxRgJSQ5dc5azJvexnRibXFtw6B8mh1iWuZUq5JyRnh1rp+u
         2icul+79TpLQiVKEnbkiuQLaITX1iVd1WDOO/mhnpqnRnK1kTPPYSni7VSdjAHbgjppR
         F26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623740; x=1793228540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rh1ct0ynFCJmpIeBgUsQvZu9SOoIsv6E2A9BdvVwioc=;
        b=s85rLLJnFCDZyN1NGiZQLVJiuhDPbAV+Z0VAzpOaP9edT6+TrBe9lSgRHkLVYGv7/h
         L7yq6IF7wY7WNfGJVyBv3I3LNrKR2CD1S3eWXB85Yj1pUCzKb0oGNJRslUk51/Ug7DPO
         ovydW0OnPh5hAoqHZquge6uw0p7RPjsTjJODWIs9JQ03Z9BUSt6OR0d9WSWYDUNzu1yW
         QELbks2RbHkG81TvBfzCNIOUhBfWOk/x2f8dPT4RW3Ib8hdzNgmBn3ultaDdBWVH0GkA
         kUKL3EOCLEMPbyoJ0GdcL5drwi/WlCkMF+zZXMlAYdGPfZmP9PR4wQnSoS3dXmXEQssj
         4tEA==
X-Forwarded-Encrypted: i=1; AKwUvBx2U7kjJjF92/5AX0U5q2i0DIrUS2fnwON1tVZmD4FUiOJWRW43TT9qHlli7JbRT4wtJo2nlkOc41zH@vger.kernel.org
X-Gm-Message-State: AFq9FYKYj+dC+ebxzXg6GIHxdMedlRhXQ/8+i9+llAs/nQk+c3XS6m+R
	4FE9JMhv/EVxAZawPYYxIYuD3pxn61c+Gf035yoxcpTfXpJXWop6Ky4Qai572ncqxqZSkq7ZGvn
	1zkhibQ1t
X-Gm-Gg: AYBFou0HTfWfd+r6574FwGmPcend9P+nIr4hFq+5FsfB4wVsSHo9n5HWZEMHCzQfgkI
	G4VkYBOel89cz5KLLY9n6CnpOESumAiKcLIWtv72WVibQHyf8vMsxMoTtjqSV3pjgoNiwDzORq7
	Wi/KZcVZyj0aI8tPT/uS60Rt5hd3WyMq8DAPAp7HLz7YexfYvqgTjZVZpwyA3Yqll5qfdIukrOO
	ykouRQ3VE9PGayFX3i7MemtEu554ZZxDfYfwzShtCci2VZwXT+bmHB7hdiUK8LGaV8yZgAZNlvn
	zzikVefRCsZd+uaEFNLpPxA06iBABky/Q7MWT7sg9qsSy+vuKpUbc9CO5jEIC8IBk73j1eCTErc
	bZOeVjXQFS3arWAtUQekoD4bpLUBNcjge/t2ORW8oma0Mxq4rSdfE/z15zO1unw7EbKQ/WNY6CT
	95MvX21m0rSHKCgU0X2Ua5RNSyvIZlm4rlnQv24JqZSfSFxPbaJg6RYAtWBCUH9YMfioIDgcO5E
	nCGbGSS1niPsjtBPb/lvgJNNCB7AHiAOFazKsRi83EgBEOGNMBm8xRR2GG/3aXWcGZcf8jISYLZ
	/hUxHiCPhl998j7SVRTpgZJci/ms5oRQlI/0/A==
X-Received: by 2002:a17:90b:2f85:b0:3ac:7c4d:8be6 with SMTP id 98e67ed59e1d1-3ad86d9e088mr2829501a91.40.1792623739843;
        Wed, 21 Oct 2026 16:02:19 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c4dsm1314919a91.7.2026.10.21.16.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 16:02:18 -0700 (PDT)
Date: Wed, 21 Oct 2026 23:02:14 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Tarun Sahu <tarunsahu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in
 the preserve ioctl
Message-ID: <atlEdhPjlyTPDWmG@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-3-tarunsahu@google.com>
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com>

On 2026-10-21 01:17 PM, Pasha Tatashin wrote:
> On Wed, Oct 21, 2026 at 11:25 AM Tarun Sahu <tarunsahu@google.com> wrote:
> >
> > Currently luo_preserve_file() iterates over luo_file_handler_list and
> > picks the first registered handler whose .can_preserve() callback
> > returns true. When a subsystem introduces a new, backwards-incompatible
> > file handler alongside an existing one for the same file type, userspace
> > has no way to choose which handler preserves a file descriptor, nor can
> > the kernel keep the existing rollback-safe handler as the default while
> > allowing callers to opt into the new handler.
> 
> That is not how it will work. If we are in the .can_preserve() call,
> it means the user has already decided which file handlers to use. We
> need to do that before any preservation happens; otherwise, we could
> run into conflicts on FLBs i.e. FH of different version require
> different FLBs.
> 
> Therefore, there should be a luoctl call (i.e via a new ioctl to set
> compatability) that provides the kernel with the specs file of the
> target kernel we are updating to, allowing the kernel to select the
> compatible file handlers. Since .can_preserve() is called when the
> user is already preserving files, the specification must have already
> been supplied, or the kernel should fall back to using the default
> (i.e., latest) file handlers.

I don't think that is the right direction. IMO the kernel should not be
choosing which file handler to use, userspace should be. If userspace
gets it wrong and chooses a file handler the next kernel does not
support, that's on them.

The problem with the kernel making a decision about file handlers is
then userspace does not know what arguments to pass in. We are adding
custom per-file handler arguments to PRESERVE_FD and RETRIEVE_FD. If the
kernel is picking which file handler to use, say for a memfd, then
userspace doesn't know which arguments to pass in.

Sure you could add some method where userspace could query which file
handlers are active and decide arguments based on that. But it feels
backwards.

I think a much cleaner solution is that userspace chooses file handler
during PRESERVE_FD. I would even require it for RETRIEVE_FD so that we
are guaranteed that the args the user is passing in are being sent to
the right file handler. Passing to RETRIEVE_FD also opens the door to
transforming across Live Update (similar to how AWS did LU from Xen to
KVM as discussed at LPC).

Regarding FLB conflicts, today we don't support multiple FLBs for the
same global state, so there is nothing to conflict. Selecting a file
handler during PRESERVE_FD doesn't change that.

If we ever need to support multiple FLBs for the same global state
(e.g. an incompatible change to the PCI FLB), we can add an ioctl that
lets userspace select which FLB to use before preserving any files.
After that, only file handlers registered with the selected FLB can be
used to preserve files. PRESERVE_FD with any other file handler fails.

That keeps the FLB decision up front and global, like you want, while
still letting userspace pick the file handler for each fd. I'd also
expect this to be rare, since FLB serialized state can use the same
feature flags as everything else in this series.
