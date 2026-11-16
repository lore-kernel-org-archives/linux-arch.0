Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827834;
	b=DOQcOfyV5GUpuRwZP0WTiP76QK8A1omto7ZZXKDT3HZzmoIPRKYg8b5bL6wpf7+JUQap
	 CPNK8+Q4ZEK/ETjAqxhVHhDwJjBAP5w9Tvrhy4Pps/PMywDBY0nmOPh3pVVv9npYBIOmg
	 8j+M+E8SA6GDu+NaEqIIMCC9yBNZ4V8WeMXuPfbDgKntDQxyBlECmx5tBsX8S8gGXhvb7
	 z3Uk9NwrwitKZhkS+AJ7+X4H4T3Qj5H2QYq0fRti5RYRwAeHBNakm9Tj3MBfnH+2HIxqK
	 MHrCOiZs1OTBX0CnuGrDIx6OpyAvSd4ykBn4ljyYb01qksF+TwgtwlZI7+U3ks6M73A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
	b=cG4clkynYLr84MrSLZkfPb0ByPC4D4WWNPOsDsLCnr0WWRuOJWcTQpeZwBwA4aOT1wxZ
	 tQHy8veqACO/bCL1M2VsPSCoeh+ri54/NTW6mr5XYXWqItM3ZC3HVC62BRRVph7UhVKsV
	 QFaOftoy3VJm8VhSJa46oe7dFdCrVO6TihJOacKGH8nrc+02bTS1/AINTN7CMmyhZScob
	 XBFVaYNa6EtI/1iDsyrhxX9b0RXJ8CBRjKnttfUKZwCUpFL5rFHxJvQnocYeuoXM8uS4Q
	 c5jzruXy3IrdqyxLiyJsSI+71nCh9MyFgHy9BATYpsGk3MLwjWVkVv2FWckbMhPPKJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVdhtEjQ;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652BA606F1E6
	for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2026 11:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 652BA606F1E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rVdhtEjQ
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490a0e72588so1525773f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2026 03:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827833; x=1795432633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=rVdhtEjQT5FeVSjeb6g1KeCSlR5WAzfAQy36NgBy24G8Giox2QE9LPzzbt6UaGFg20
         dmoHkqnkTYm0HKTFVPgXMm50xQ7zxGmwscbQp9b2ezCn9mA436p3+7JIgS1yW8dgeXC9
         nfYhNw53+TIFpt6+SE4H+9FUJIhbR8zphpCjI1+mIXv8dvNLdbmO05X5YWYCAlkPK7eb
         f6iCEfx46EWybkK2aiebuDDLI6wMPFOvAPoZC07MvR6rqVRHexrTmKf50yOkAIscUDkB
         SZu3GAngH4UyKACxxK2RRwNXPcsz6NLOW7SZFKczhfldBlGdj5FDcsiVAzFHA7oS8Ygd
         nDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827833; x=1795432633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ITw6ygw2AXNWGd7QRacWknaddhmjMVGAScdWdo2ralM=;
        b=NMaH5vEZHQ0oijkMIAZZ8e6Y2I2XG5bGHMoUklkh65ZP4do0xliVcGonPhxieJlKEG
         y8hQPt1Yrv/oup6WPghjsfNj0sXJnO1LaJg991JlxqMiOTxnH/hRMu9rwxpoNf1ygNGv
         3rHtLIqNCs9EVgFEJMZVcxrNdiZn8TzNNhJO2SqBioiBcm+MyXFyJn3Uxr4xBNQcQypb
         gs33Uv9EF3bRRdGLDZdoKgzyRjzB1XHXcbZod7ulpvuhWGVuwA62XdC7SucZl8S0FwZ/
         Ml3pspb8XDAJKTdbtyr/WiBtuulQ1qIBdX57cLsHZV8arSZc3lndc23K0oYXhwtQQGbZ
         tiow==
X-Forwarded-Encrypted: i=1; AL+hErEynd5roB0JRtsrjYYDSz3+kT5VeDaM0peBkjbmcCfieg+oLHTDSOVjEaEKGt8GJNafjNiPtrgJHCVm@vger.kernel.org
X-Gm-Message-State: APuU4Z8yJSVUa2aYk8z/lIgIfUgL4V7sG/+ZxE+D9ZQA74W1KzRa332n
	90ZxY0rYNyFvDg1c0R9JJLaJBxBS6RCHaIVK6bPFKB0eal+OLCH1R85b
X-Gm-Gg: AZFdTZff1KHRTdjFNwPVtIQwCnQoYs4cM48/bAYPeLu683YCPOqz30TVrkbTjD9hOJU
	8cPjCJ/pcWmHyS7fuUXxi99Ev4EzhigFrWn1ma1+uRe3kp3zs79zVMO0E58EfB+r0YDAMSS8QQh
	wO89igWDtYU/d6X178ZYHHuP2ut1kxKDdFZSbGqiQt9VxuofXL5ciV2tpphOqy2bqUFEnC8md1Z
	AEv4ExB86lSnFa+TeeqRwZuZR/C5jrQ6EIfz1xgSVwFUnzeSx1HHMbXqru7CXZ5HmzM6zV/Q5GP
	qpKLpF+Q9zy+OrYzSWwoigeyX9K4xCGYxrHBY6cWOXnEN1Lll/m+PYvUbCVgYfv+SDYu7QKbHqB
	b05nhmZWg+O3qcKRfObp/tbbGlgMsbyuMFjC15cPfaScXd/qkPud5E7ALGo9hj/qqZrzDeb8pfh
	UddntocchRVAxVGuq9P8ZkVdRRl7kzl6HjhADANfwiD0x85fF5wkoEN9ou8GcERR46GMkoI1/fO
	HGkmcEPE2hkGU/iC76KEQRByxeiBruhyA8h2xCHBZ5AsAqWupkzwTFttAaIzGIBecQy1xfF8knx
	T9dmi8wQdcvjk6l9Ju1lLnZzAcdx7ERYD6nVG9GP4+rNWUp4Dy6DxDGLWHlmn+uv6ay4ezApnoX
	MzwYOoDrD8BeE
X-Received: by 2002:a5d:6f07:0:b0:490:f98f:addc with SMTP id ffacd0b85a97d-49c71d48742mr21084457f8f.27.1794827832625;
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm39476298f8f.7.2026.11.16.03.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:17:12 -0800 (PST)
Date: Mon, 16 Nov 2026 11:17:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann
 <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>, Lukas Wunner
 <lukas@wunner.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, Jim Chow
 <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>, Alexey
 Makhalov <alexey.makhalov@broadcom.com>, Wei Liu <wei.liu@kernel.org>,
 Michael Kelley <mhklinux@outlook.com>, Nathan Ciobanu
 <nathan.d.ciobanu@linux.intel.com>, bcm-kernel-feedback-list@broadcom.com,
 virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/P2PDMA: Allow P2PDMA on Intel Xeon server
 CPUs
Message-ID: <20261116111711.7b473feb@pumpkin>
In-Reply-To: <avqhIQ2krd1qgp6K@infradead.org>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
	<20261111234439.4098-4-pavel.e.popov@intel.com>
	<avqhIQ2krd1qgp6K@infradead.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Nov 2026 22:22:25 -0800
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Nov 11, 2026 at 04:44:39PM -0700, Pavel Popov wrote:
> >  #ifdef CONFIG_X86
> > +/* Intel Xeon CPUs whose host bridges support p2pdma */
> > +static const struct x86_cpu_id p2pdma_intel_cpu_ids[] = {  
> 
> Why is this in drivers/pci/ instead of behind a clean abstraction in
> arch code?
> 
> (and the fact that the CPU vendors still haven't managed to provide
> a firmware interface to expose the P2P capabilities is just insane)
> 

Isn't it a motherboard issue?
Since it depends on all the PCIe bridges on the motherboard.

IIRC P2P can also deadlock under load.
So it needs to be use with extreme care.

David
