Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.178.41.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410672;
	b=BXVdGWLd2ukwSO80ZewBQLZfanGMV2WAGyJAQh5hXGBX3Wpk1m59PkOmrEUmOEMEl91V
	 AQedTS3Up6bx9KH1Cy250vcrRLEr3V25FSZ4lZTSRO+CM5NbKbr6wGTsxi/xuGMpvuP9c
	 gsUsmE9/5hNo11UWYJv01utm4/1VPr7wZ9Xz9RjWGyM/p3aFBXGZWKgyz9IE2FpC+FS27
	 Or5TOWEXi4r8n4zew++ubWfHIJrsAgLjArtpxWy3qrk6azBUY7gBmttU2JO9wUWHjpya6
	 izlXohBRuhbOKEWo25Lgpo5JXocr/IuzyA3T51MfZjj1EzLOsF8LRyY/jWBr/rN0PwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410672;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=joqpnfazpg45b8CAOPhTIGRk8ga+vSwh/VQww6gpLz8=;
	b=NWn0gvKyUJ5JVJFK5/2ZyoqicLGU/beQ6ai+1keHxZGiGhMaMae+FXLZLjCNfU3YJdTS
	 0bajIPxb6NvhOczbSt7kTpxKRllC8Jpva5/QNEsz4A+tKQs1bhlpycwCZtAUtKrinagAM
	 MuE7qrEJd/PPLJtlwdeiIe/1FmoGch+K/mr8bCYTb9Mz9unJpvfjaF3dSI0tfYSF+iuWx
	 dQCWsXonFzk6Bm6aGciOqkPdPlllAnpPzCnLi1VDJVf6/48e0MAwAHSUb+TilDOaKqZiE
	 31UcKni+eLf5dAAm4KJOJm6rewDon9nst7VvhBanlcM3+1uJDgOTTRnb6o5kB4nQJDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bencteux.fr;
	spf=pass smtp.mailfrom=bencteux.fr;
	dkim=pass header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b="MCT2UNH/";
	arc=none smtp.remote-ip=51.178.41.114
Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206A606A321;
	Wed, 11 Nov 2026 15:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F206A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=MCT2UNH/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1794410489; bh=DQZ/K8C5Xuvonbckgw4rX87bpSwrJG+odV2IIvPcb0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCT2UNH/sg5PVMBKhGCRYKzj0DbK8bi9cxaj+UiCJk5T7ZWUQL6l1Yu3I+MFALkOq
	 vtCoOshcPucn5uqwleBzXDCMBqmJRIS2vW6h2449+5xxwGYuP6c9+QEU+t9DxlKwZx
	 0SVUNx7YDorK5WQULnj6h+AVLc1xIf0cjsEFciOY=
Received: from localhost (unknown [146.70.188.209])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 33BBF4029F;
	Wed, 11 Nov 2026 16:21:29 +0100 (CET)
Date: Wed, 11 Nov 2026 16:12:05 +0100
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: add missing syscalls to signal class
Message-ID: <avSFxQDmHlxNhrJ7@ultrabook.localdomain>
References: <20261111110200.30415-1-jeff@bencteux.fr>
 <e817126f-83b7-4450-a893-ac4e59460ae1@app.fastmail.com>
 <avRzKRB2f_dP-xEv@ultrabook.localdomain>
 <6f26e8fd-6198-4c2c-9702-3b7b8dc73f7c@app.fastmail.com>
 <CAABTaaCAhp7n-yNLMPoyJ6=uYaLjkA82KT0CTG4MGfKHdjMvDQ@mail.gmail.com>
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
In-Reply-To: <CAABTaaCAhp7n-yNLMPoyJ6=uYaLjkA82KT0CTG4MGfKHdjMvDQ@mail.gmail.com>

On Wed, Nov 11, 2026 at 11:50:48AM -0300, Ricardo Robaina wrote:
> On Wed, Nov 11, 2026 at 11:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, Nov 11, 2026, at 14:52, Jeffrey Bencteux wrote:
> > > On Wed, Nov 11, 2026 at 12:18:01PM +0100, Arnd Bergmann wrote:
> > >> Why the #ifdef checks? These should be available on all architectures.
> > >
> > > I included them as convention, should they be removed?
> >
> > Not sure where the convention comes from, it just seemed
> > odd that you have the #ifdef checks for the newly added
> > entries but not the ones that are already in this file.
> >
> > I had not checked the other files that have similar ones.
> >
> >      Arnd
> >
> 
> Hello everyone!
> 
> It's not a convention. Arnd is right, ifdef checks should only be used
> for the ones that are not available on all architectures.
> 
> Jeffrey, please take a look in this commit c0d73c09381e ("audit: add
> missing syscalls to PERM class tables"). Note that '__NR_statx' is not
> guarded by a ifdef.
> 

Arnd, Ricardo,

Thanks, it is now clear to me these are always available.
