Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401E3451AF
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366716; cv=none; b=lL2aSC/tnBEFJ2qK5g28497Sc0UmP2C1cOye/o6DCXHsedQFLx4Gzwt3TffpeQZtA/d9IHDew64+RzLJgRhajNfrdbqO89JTv9LXRZwXKj82XUahzOVD9f37oGUQnfaK5UrFE9IlH/dbLyocsRckhjP9tEhzzDm5xmu4VICzta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366716; c=relaxed/simple;
	bh=jR5KJZGMlz23mPsok3FQoZISEQ6swfv4cscZ531F7eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAeprzzuwTns/2yHvUYpAMnSFuUTrBjR5egvqeotBZrwRKu0m1+BOIrb0gLNXj9gQgi8GGx9J6C2J44v0gJnEZiq45k+xFK8INv7d6yiEhFeUUrj01EXD6tIUcot+wHEnWpRswID4c0Sr/V8SslLi61DnuvqvFYGNT0jd+iKfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUpgYhbS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUpgYhbS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783366713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4jy8N6CHsoO0qBJcu9tNHJow21Fhyrg7lFoJBMxRas=;
	b=UUpgYhbS2B8gr1XvjuQfTbn/Gdg9xoMzqtJX+WAJUKTvTmhBvGHULPk8PmNOiMwg4JcPX1
	QFyXOp0jvbBeGhl8iaepNVIoxuHy/O42djgaEKadyqWDV1qIc+NDEKeYETq27lPUfkPCS2
	QTC2qo9wg0PxZ4x6RHwt2J1rZvZZkwg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-OlUtYZw_MImt1suw0vWjGg-1; Mon,
 06 Jul 2026 15:38:30 -0400
X-MC-Unique: OlUtYZw_MImt1suw0vWjGg-1
X-Mimecast-MFC-AGG-ID: OlUtYZw_MImt1suw0vWjGg_1783366709
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DECDF1955DBA;
	Mon,  6 Jul 2026 19:38:28 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E09B36924;
	Mon,  6 Jul 2026 19:38:28 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 666JcRhk1947632
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 Jul 2026 15:38:27 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 666JcPa11947631;
	Mon, 6 Jul 2026 15:38:25 -0400
Date: Mon, 6 Jul 2026 15:38:25 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: make the *_bit_le functions use unsigned long
Message-ID: <akwEMdVwjX9wRzJz@redhat.com>
References: <20260702194307.1805533-1-bmarzins@redhat.com>
 <akfsMU0h5BOvLOei@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akfsMU0h5BOvLOei@yury>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Fri, Jul 03, 2026 at 01:07:21PM -0400, Yury Norov wrote:
> Thanks for the patch!
> 
> On Thu, Jul 02, 2026 at 03:43:07PM -0400, Benjamin Marzinski wrote:
> > The *_bit_le functions use a signed integer for the bit number.
> > However, the *_bit functions can use an unsigned long. This causes
> > problems if there is a large bitmap and a bit number > 0x80000000 is
> > passed in. Since that is a negative int, it will get sign extended to a
> > long when getting passed to the *_bit function, turning it into a huge
> > bit number. This usually ends up with the memory address wrapping around
> > and the function accessing memory before the start of the bitmap.
> > 
> > Avoid this by making the *_bit_le functions take an unsigned int.

Err... I mean, an unsigned long.

> > This can be triggered by faking a huge dm-mirror device, which uses
> > bitmaps to track the mirror regions:
> 
> Did you miss some part after the colon? Can you add a reproducer here?

Oops. I'll send a v2 patch where I clean up the commit message to
mention the correct argument type and don't accidentally turn my
reproducer commands into comments by copy-pasting the hash sign from the
shell prompt. :(

The reproducer is:
$ dmsetup create bigzero --table '0 8589934590 zero'
$ dmsetup create mymirror --table '0 8589934590 mirror core 2 2 nosync 2 /dev/mapper/bigzero 0 /dev/mapper/bigzero 0'

This will crash the machine without the fix.

>  
> > This will access memory before the start of the sync_bits bitmap, and
> > likely hit the guard page of the previously allocated clean_bits bitmap.
> > 
> > I looked and didn't see any crazy code using the signed int to
> > intentionally try and access bits before some address within the bitmap.
> > 
> > Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
> 
> Taking the patch in bitmap-for-next.
> 
> I'm aware of the int vs unsigned int problem, and already aligned some
> bitmaps code. The cpumasks and nodemasks are all signed, but that's
> not a problem in there.
> 
> The 0x80000000-bit bitmap is 256MB, and I was not aware about bitmaps of
> that size. If that starts showing up, switching to unsigned ints would
> only double the capacity, and that may become not enough quite shortly.

Yep. The code uses unsigned long. The commit message was a brain fart.
 
> Can you please share more details about your case? What does 'faking
> dm-mirror device' mean? Is this a real case in production environment?

I used dm-zero to make a virtual device that's just under 4TB, which I
used for both legs of the mirror. That is an easy way to tigger the
kernel panic, but you could hit this with any device larger than 2TB. At
these sizes, you would need a 2 sector region size to hit this. I hope
nobody does that. Picking a region size that is less than a page size
should probably become an error. LVM's default region size for mirror
devices is 4096 sectors. To see this issue with a region size like that,
you would need to be mirroring 4PB devices, and I assume that anyone
with massive devices would use a region size larger than the default. So
I doubt that anyone has hit this on a production system.

-Ben

> Thanks,
> Yury
> 
> > ---
> >  include/asm-generic/bitops/le.h | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/asm-generic/bitops/le.h b/include/asm-generic/bitops/le.h
> > index d51beff60375..e3b0da9a25f1 100644
> > --- a/include/asm-generic/bitops/le.h
> > +++ b/include/asm-generic/bitops/le.h
> > @@ -16,47 +16,47 @@
> >  #endif
> >  
> >  
> > -static inline int test_bit_le(int nr, const void *addr)
> > +static inline int test_bit_le(unsigned long nr, const void *addr)
> >  {
> >  	return test_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline void set_bit_le(int nr, void *addr)
> > +static inline void set_bit_le(unsigned long nr, void *addr)
> >  {
> >  	set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline void clear_bit_le(int nr, void *addr)
> > +static inline void clear_bit_le(unsigned long nr, void *addr)
> >  {
> >  	clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline void __set_bit_le(int nr, void *addr)
> > +static inline void __set_bit_le(unsigned long nr, void *addr)
> >  {
> >  	__set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline void __clear_bit_le(int nr, void *addr)
> > +static inline void __clear_bit_le(unsigned long nr, void *addr)
> >  {
> >  	__clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline int test_and_set_bit_le(int nr, void *addr)
> > +static inline int test_and_set_bit_le(unsigned long nr, void *addr)
> >  {
> >  	return test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline int test_and_clear_bit_le(int nr, void *addr)
> > +static inline int test_and_clear_bit_le(unsigned long nr, void *addr)
> >  {
> >  	return test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline int __test_and_set_bit_le(int nr, void *addr)
> > +static inline int __test_and_set_bit_le(unsigned long nr, void *addr)
> >  {
> >  	return __test_and_set_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> >  
> > -static inline int __test_and_clear_bit_le(int nr, void *addr)
> > +static inline int __test_and_clear_bit_le(unsigned long nr, void *addr)
> >  {
> >  	return __test_and_clear_bit(nr ^ BITOP_LE_SWIZZLE, addr);
> >  }
> > -- 
> > 2.53.0

