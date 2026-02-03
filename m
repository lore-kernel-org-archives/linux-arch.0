Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CA4394485
	for <linux-arch@vger.kernel.org>; Tue,  3 Feb 2026 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770107007; cv=none; b=ei14dk0CQpBI9k6Fj/pUs7QQp5vZuqtS9WgsK7iCsRHNi0bbyO8Q1Qc8d0bukyFIpN39hPMT5f2JhgjwJB5N44DRHsK82y4Jgaxtbwkfkosk+xVltPCifUVRQHr89qMxNrZR6yviAeLNHRo8EoxLYwbJQqDzrQJRail4UaCpT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770107007; c=relaxed/simple;
	bh=0vzqwSZoiSyyQwx0kNIc+hthOck63XO3L0c6JAyV00E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ncbWeetROvJTOafEuimLvxfYD1O2uIN9ZdV4zdOyc9phAefi6GOfvW+3/pnIuxOHsJJWWtDs4GxEVeSNXSD/QtU80aOVDfqrCWATaNov60+Ms57oGkLEq5J6cnu+HyQeTueYcnQDIa/VC+SrlojPIQ8ikkf6a9wAQqHt0J1sqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4Ud+oPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4Ud+oPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770106999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vv0j3G+SzAoWpK+TUc6fyFah4RU5Ag6+PMWNgWTKGCI=;
	b=P4Ud+oPkU4JkXG5/IeKflKJgZr1t4WYY/5gMqhKVEV0Dci3xr5BqZsnTh0iutZfT378GS2
	VMD86klFVHLzdZYUDATTU2I3+mfcH7pI1anXxoQvcjM1W6ecYJL7Fg1WHyLHuCq0aLUIOz
	aQtbTyTkji8baf9fO0B1/8rN/j9VXi0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-t1AtFM9yMj2neNRwxj3iQQ-1; Tue,
 03 Feb 2026 03:23:15 -0500
X-MC-Unique: t1AtFM9yMj2neNRwxj3iQQ-1
X-Mimecast-MFC-AGG-ID: t1AtFM9yMj2neNRwxj3iQQ_1770106990
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB8FB18005B5;
	Tue,  3 Feb 2026 08:23:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F302119560B2;
	Tue,  3 Feb 2026 08:22:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8b12f1d28d3859467c3b5f6bc352038ce7627e54.camel@HansenPartnership.com>
References: <8b12f1d28d3859467c3b5f6bc352038ce7627e54.camel@HansenPartnership.com> <20260131073636.65494-1-mcaju95@gmail.com> <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net> <2316630.1769965788@warthog.procyon.org.uk>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com,
    Mihai-Drosi =?utf-8?Q?C=C3=A2ju?= <mcaju95@gmail.com>,
    linux@weissschuh.net, arnd@arndb.de, arnout@bzzt.net,
    atomlin@atomlin.com, bigeasy@linutronix.de, chleroy@kernel.org,
    christian@heusel.eu, corbet@lwn.net, coxu@redhat.com,
    da.gomez@kernel.org, da.gomez@samsung.com, dmitry.kasatkin@gmail.com,
    eric.snowberg@oracle.com, f.gruenbichler@proxmox.com,
    jmorris@namei.org, kpcyrd@archlinux.org, linux-arch@vger.kernel.org,
    linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
    linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org,
    linuxppc-dev@lists.ozlabs.org, lkp@intel.com, maddy@linux.ibm.com,
    mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au,
    nathan@kernel.org, naveen@kernel.org,
    nicolas.bouchinet@oss.cyber.gouv.fr, nicolas.schier@linux.dev,
    npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com,
    petr.pavlu@suse.com, roberto.sassu@huawei.com,
    samitolvanen@google.com, serge@hallyn.com, xiujianfeng@huawei.com,
    zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Date: Tue, 03 Feb 2026 08:22:52 +0000
Message-ID: <2546011.1770106972@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> > There is another issue too: If you have a static private key that you
> > use to sign modules (and probably other things), someone will likely
> > give you a GPL request to get it.
> 
> The SFC just lost that exact point in the Vizio trial, so I think
> you're wrong on this under US law at least.  There's no general ability
> under GPLv2 to demand long lived signing keys.

Cool :-).  I just know that I've been sent GPL requests for kernel keys.

David

