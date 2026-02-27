Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0535A3AC
	for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211635; cv=none; b=AbdzHkfDnTaXIZ3pi47BQf8aPCtVVhlyZQj5aIscz5P2CP88L9xm0P1G0HypQY5El3/sbYoQskNF8NJMmg9qAKEae4URj7KwJgnAomkNPdiheR3BXG43WMKhBGX257VVIPNFGDa3Dpfz8uTLqaABNZdmCyf+hSdZz3XaN/QtIrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211635; c=relaxed/simple;
	bh=7YD9jAVjWCDsjoaYpV+aypTDMdl99H+ZTL32bN/H+O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjOPvk28epusJ4d4F5FyEUfi4OA/TyQjxLxBRQqJBlfYgMWda69/n0LBR233JwdATtVk1ajiNJyZ/SgwHR+z4mBDt8rP6b2ofG2AEoYASnyh2yoR79f9hnXFkfht/84AMOjiTJOykAtnyXktSryy2E+fJuAtcgV+pnWqN/5qdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=ErxFW1Il; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="ErxFW1Il"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899ba9a699cso13406986d6.2
        for <linux-arch@vger.kernel.org>; Fri, 27 Feb 2026 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1772211633; x=1772816433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q632p5k5HIhX1voseqCzyNwQgf7bQCIjs7aoYu62cBE=;
        b=ErxFW1Ilt0Y2QZt5MuMVpDxy45GRlJUCgCCbZ20MK7KLlishYzAD2aX/HhWFrQLpbq
         HE+bNBwGcmCcVxeT2yrBk70Be3Bk9qKQHu0zzRXRKBZIp1VaU+xcbT1zSSboCmvSwCGG
         3IhX+fKfYLWYhUE1izVUPVFkc8Vls3/4XJ6eBLJG7k4naP7F8c6nCRKuZo8CP0JR3ghB
         +f7kXeelG2k8s20vYFHLVAkri8TEcqN2ZPstDz7YZ3KllPZy5I3RhrJKhvymoKTmjv0S
         vfGOB8blyiLUhuUDlDnAEaPmmZEvcd1tZU3QAV2DEQAjY34GF6cYXilJ3XdZVLSGzuFv
         xIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211633; x=1772816433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q632p5k5HIhX1voseqCzyNwQgf7bQCIjs7aoYu62cBE=;
        b=CzM/uUh8TuuWNJUlBPEQl6Sj9v1RW4WeyF6jMmI0BVrzh27zwFWDYdYUaWtJZIZT97
         3Si7iuJfVDe8ilJfZ4+ENMzKroIUGpya7C4jzSrQ74Ka0vKZc2FLw0On0NL+yytbCz59
         SRLe+tFwLePTy1qkzBOkW6PtGgDoeLPTyW25/8Ogh3zPS3y20NHsuEOyXRq5SpHpIfG/
         MU1/HmgS1OBSP+lsAwds9qPP2gYaJMTQS7Y2DDLt4vuyThA1qSijM6bDnbp9EsoNtLed
         CdZjUliMBiEXHEa1YsYr8sl/WGiQO+IJLobzuCNIuuR3RtedMOzlSHaY9enjFVQJnQ8+
         omeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmCh4Pt1b424EHY1aHvYawVrR/ZQEGrSzVFCTMkXr/wqzluzHkyW+fMOooEo1/1a5vX1QecJHnwXXE@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyCBmFUTDt9lbFKCziaO2U91BzWf5h0pG5Pe7R+IuWyHINhr7
	xOJtK9Ta7Fey/qlqAzq5uqY5WSXlgp++rgqW0gwBHAZObIwN1XGQ1dSK8Adm4Vv6nA==
X-Gm-Gg: ATEYQzxDt/oPC53OKHMp3FfSn2+573BjM1Odu4Afyf8GblcGRpb2ae+aQIJUNLkp6K+
	RDinbJmUUF0U5i7WzzSN59SglBr9spVMUr+k60SkV214KQ+kdzS0vZk7zVgL2ucg4vUYavRX3Tb
	KLHHG9TS/nIhXRYFcDGzOystPuC8rOiP9dN6/Ya3YrBg5w9LKqF0IFcB/XGg0czLtAuUJ4WUkU5
	rrdGCL+C95LS3oltdWwHnjDzR01JlyAVXkfLhzsi2ItRFKU0ubh4FVM9fREvuCkak9gFBk9Z7dK
	tqrMJGq8uRpHGR/lVF2GUnC1Kf4HxXL+x4BVIAWIeE+yjOKcMFGRgpRT5839vdH9ULawVsHoj2w
	7l/fMXAu73Na9rDYDpPYyAF9U/3JVa981wObfDM9Ce0HHD4EVI+VRaV+9GsiNsZwfMKxGcVCJKO
	PoZwP0A39i+X5U/spQNAt73cUn
X-Received: by 2002:a05:622a:204:b0:507:358a:2b11 with SMTP id d75a77b69052e-507529dc2e0mr45494721cf.67.1772211632498;
        Fri, 27 Feb 2026 09:00:32 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::687c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda0asm53695991cf.24.2026.02.27.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 09:00:31 -0800 (PST)
Date: Fri, 27 Feb 2026 12:00:27 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, Dmitry Vyukov <dvyukov@google.com>,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Akira Yokosawa <akiyks@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Luc Maranget <luc.maranget@inria.fr>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	David Howells <dhowells@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>, Boqun Feng <boqun@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Marco Elver <elver@google.com>
Subject: Re: [BUG] Memory ordering between kmalloc() and kfree()? it's
 confusing!
Message-ID: <556c5caf-c453-473e-ba92-f49ac34053a0@rowland.harvard.edu>
References: <aZ_lJAqxh_hNGr_v@hyeyoo>
 <9dcd02b9-42da-455d-aa08-165e6ff0b921@rowland.harvard.edu>
 <aaByMLSAIJM8HdbO@hyeyoo>
 <d8308828-ed28-4650-8c8f-22a7e5cfd1a0@rowland.harvard.edu>
 <aaB-1e1LoxkcYl2f@hyeyoo>
 <9240040d-598e-48bd-b802-bf91cce92d0c@rowland.harvard.edu>
 <aaGP1Se8vkBhn9uj@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaGP1Se8vkBhn9uj@hyeyoo>

On Fri, Feb 27, 2026 at 09:36:37PM +0900, Harry Yoo wrote:
> > Which is: The same mechanism that the slab allocator uses to ensure that 
> > CPU X and CPU Y won't step on each other's toes if they both run 
> > kmalloc/kfree at the same time should also be able to guarantee that the 
> > metadata changes made by CPU X will be visible to CPU Y if Y manipulates 
> > a slab that X just finished with.
> 
> Within the slab allocator, I believe there are sufficient mechanisms
> (either spinlock or cmpxchg) to prevent CPUs from interfereing
> with each other.
> 
> My earlier statement "Because the slab allocator itself doesn't
> guarantee such barriers are invoked within the allocator, ..." may have
> caused some confusion. To be clarify, the slab allocator of course uses
> proper locks and atomic operations to avoid CPUs interfereing with each
> other, and yes, those mechanisms should guarantee that the metadata changes
> made by CPU X will be visible to CPU Y e.g) when the object is transferred
> from CPU X to Y within the slab allocator.
> 
> What I meant by the statement was that the slab allocator doesn't provide
> enough barriers to ensure correctness when a user performs a drive-by
> free on a different CPU w/o proper barriers.
> 
> Hopefully I'm not missing your point this time :)

You got it.  :-)

But since I don't know anything about the details of how the slab 
allocator works, can you explain in more detail what the locks and 
atomic operations are and how they prevent CPUs from interfering when an 
object is transferred from one CPU to another within the slab allocator?

In particular, which part of the mechanism fails (or doesn't get used) 
when the object is transferred by the user with no memory barriers?  I'm 
trying to learn exactly how these two cases differ, because at first 
glance I can't imagine how you could accomplish the first without also 
accomplishing the second.  It seems that transferring an object from one 
CPU to another within the slab allocator should be very much like 
transferring it from the slab allocator back to the kmalloc caller.

Alan Stern
