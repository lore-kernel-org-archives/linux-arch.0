Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1F0442FA3
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979754; cv=none; b=EHn2dIZ4qYDmjqg+3+kaLo6fSX4Rx6yKFdNRLSYe/WxyPgMq9qZ64olMBSV8TjUtFO4neJV2+6Pu2wyhDxHk2Gmh1Kj6qmgFPn4fI40vdny8NhIZEYd0/Dj4IBXlpfNnMBlGITE0AB2sAihvvjroldU/Ws8gcNy2IYVvVoXP41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979754; c=relaxed/simple;
	bh=/9zL4j7bvEzNHZe+2GnRD64ks0ouO6ge/iHUhPBHSpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O17LmfllVPPv4LQfrd4kwONXYZ35jfw2xlxUJzUvbH/7MQMwa1DcTl8fcSaIkfdqHMNu9OU9xZZbxnLpVbQA9Cbb8htQWZ3q2RdyMMq03jKBXIFADAZJ6pVsprnFI46GGOM33ih2O3haWPE3RroE7Gx1kNekVzNDebzWdQKkw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nURkaZkS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nURkaZkS"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5b048375so179215885a.1
        for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 08:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1786979752; x=1787584552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LkIXCvEaOBZrdi7ChK3r5JFweXwKUKZFGDYp1HFtFrY=;
        b=nURkaZkSS1bFk0F9xKIrydT+A4Tbczk/jA4xGpqFU4pBJoP+aZ/Skuc1oMLRGSGl9r
         WO0OCIEPs5emafGVagWsIGAbiNCLo2cD1/eMeFIfqB8+t4q/zD/TDCoqsli6ywNXD7jk
         Y52TD7Gj5oOWKx70Rb/gd3KPYsGMVa5CvRyBZCrCOes71OqXN30YMfzRB/abf0M6fp0o
         RHAAh9MmrqRaY6+gNTqPp2RwexWzHoe5pzaLKR10S7s4rMlr+OwlMWDIEQTYtyNMIH5p
         WdjfJ4csOa+UWGleBQRIlc/r+l79t4gZDgnlScbxETCUATW9YHfV9bP5SHTRagD8YyFG
         m3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979752; x=1787584552;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkIXCvEaOBZrdi7ChK3r5JFweXwKUKZFGDYp1HFtFrY=;
        b=R3c0fb45ZUY/TUJExi745ahLuKxFHyddeAvbD17w3a0QrrloCaO0oshlgv4yBU+dm2
         PP1YvVjLN9ZIhSGKt0/EnLz9+bIu5Mpd2D06MMhkEcQrGszWGwtqgp6rUDasJ08ScvBg
         49tyKUuCUb02LU1K5irPCuP6pKmtMZhS8HeMWMz13Nqon5UC/9BNqeTQd3u4CkEvnOuX
         Pr3mUczay1VJcq6qpt67E4IThxDJSo/JD7tO5aZSqMAbP7swagxzrtMkEEML7YD7HXCw
         G5kwcjYk/4b4NMPC+EokACwfBI7dCDCUNlOcIdZ8xCmzUTxPD4kpWf7eVpVHJIkUntv/
         M2LQ==
X-Forwarded-Encrypted: i=1; AHgh+RprfN+lyu73mL58SSkOlegY1WNecmTwi9WfscAxvOJg74oEznpAAowvU9Kz1keq+pfzjbzA2zDctVAl@vger.kernel.org
X-Gm-Message-State: AOJu0YzJg4Sqcspquz9N2gXE1BfrvbqU/sPr0mm0t0PRBJrh6rvky1mD
	w5JrCJ5AoT34rHPArL47hGUwp0dk8d3ioRPmnvbre8suYZPZYEKZfCbcjCjpJtw/7KQ=
X-Gm-Gg: AR+sD10qpTHApZGRCos+XjQDjxJmdvidzfTzUtOz5DqWBrFbfX2CnHTp1CLikkHMjM8
	PoGs5FiRHkudX1xYxCDH6J9Nq3nzcQsoJmuDCbcclblDN+5QsLNhflUsQ93AoxAk5gRy/8cKxmK
	QTBbSyMtoVqm8+bw5p20eji7rytXPrbuXDAJiSsEbGRC4IVM2cvi4Pyd8WhdA8nDt2X3FLxScRk
	h0G7tTieMgoB6LCLufZ/A/WiSPDYjQlcgNf4HDU7H1rXj/nLBmfbkNhLCaf0YyfTdfAN4nj2C1W
	DpJyTEFcTOdAiE1MzWnuwtP8DbLIub9vc6nXs/Mvx/bvXk+gv1d4uxgH8MHr72CJJeCLgUWFGy/
	XIEBXioNUWRFP4TeEqLiorVVQznWk7FEcjViZklcIR8Zjo9WlHRzSVwncUijBiwZN9Ewhg3pgxD
	RSK/x4Gtk4s6CfPNQNvfXGS1eTknvVHYaCEKEky+0rzlU45+bWiUuCyTbwaqQYqYwBbtbjeyH37
	Gj7tXTyvxBmu1U/MUEowe9p9cMb5edftrimHmruE/af
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id af79cd13be357-93704b7d4dfmr142017785a.27.1786979751821;
        Mon, 17 Aug 2026 08:15:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033d2ccdsm67050085a.30.2026.08.17.08.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:15:51 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:15:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Rob Herring <robh@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Saravana Kannan <saravanak@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <baoquan.he@linux.dev>, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/4] kho: rename "scratch" to "bootmem"
Message-ID: <aoMlXHFTvcpwOv8W@gourry-fedora-PF4VCD3F>
References: <20260811162642.3504565-1-pratyush@kernel.org>
 <aoMdJ7hpr1GonLz8@gourry-fedora-PF4VCD3F>
 <20260817145231.GA579285-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817145231.GA579285-robh@kernel.org>

On Mon, Aug 17, 2026 at 09:52:31AM -0500, Rob Herring wrote:
> On Mon, Aug 17, 2026 at 10:42:00AM -0400, Gregory Price wrote:
> > 
> > Is there a non-verbiage reason to justify these changes?  Living with
> > "scratch" seems better than potentially breaking folks.
> 
> I don't think these are the first breaking changes. And if the changes 
> are fine, then that means more breaking changes are fine, too. So why is 
> this upstream at all until the design is settled?
> 

Surely we should not break deployments for the sake of renaming
something that is very arguably already aptly named?

~Gregory
