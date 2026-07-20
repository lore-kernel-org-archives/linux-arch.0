Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785B32B99E
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566261; cv=none; b=ddqB6FTLSou7L+6lKrpT2RJvyrAY3fDL44fwGFz1vTDLqytrelCZHqeY0F7R5S3gCVhf9H1jDrAdbTfdbqd4tPsJJ8kTcYcN6kSn3TQ9w2sCaJcVMVO/Qn08kit9rn4pXXKsoOcd1r7sUevC+PQhm4fgendaglt/3EuTmTfVyhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566261; c=relaxed/simple;
	bh=xiuXsT7XdacxTNIaCEPX2xle/BDBo7iIWuCIWqBwOMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7Zg31PYkkYRyWa/mzhTS7tAhbWVQBhGbqJ84ub5VLixFE4D5jrWJKySjvgs23NVrTzpxhr7gdwmPlFSDFuX1dxNH6ieX+AxFaPgh04Yau2dP8NmrqCNj0Z+GnQDZSBqRcNp7//zHTckkvknHw/dYPTimd728x3hE8fVNdTn54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wr4Rr3r/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wr4Rr3r/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 831E81A10FF;
	Mon, 20 Jul 2026 16:50:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 50A6260360;
	Mon, 20 Jul 2026 16:50:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5208E11BD0382;
	Mon, 20 Jul 2026 18:50:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784566254; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sjX+9x0hottSvvIBjAOtiqc812VcJKoGeEL9Lkzb2Wc=;
	b=Wr4Rr3r/gj7+03fa3rdg1Ic99q24vYMoan6WwJP/OjkbaywQwGDpFG7KlkAq0LIjgCflnU
	6OSOnKiFYG1DKm19zddJi9qOCG+n+RLcnezgOxElqTHLgSM7axBI81NaZc/LF97aE9KliK
	D2Ok0qr1JD7GxegCq6sBRzA3VcO5CdDHOfpWOkTI3kZNPobNV8413+VynOdiAjW+cdRodw
	ZGFVMN9I9IbOjEJ+O7X0848yjtI9zJErNqo5qOK+x2auQHRlGe7zls6iqGxYmKJTMT58tC
	f9M/NGIOz99bd13Gjo/nqEn1oyZFeIh4SSSXoMEPaTJCgjhY8ccynvXcgat2AA==
Date: Mon, 20 Jul 2026 18:50:47 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: git@amd.com, michal.simek@amd.com, Frank.Li@nxp.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	arnd@arndb.de, quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Shubham Patil <shubhamsanjay.patil@amd.com>
Cc: radhey.shyam.pandey@amd.com, srinivas.goud@amd.com,
	shubhrajyoti.datta@amd.com
Subject: Re: [PATCH v10 0/2] Add AMD I3C master controller driver and bindings
Message-ID: <178456622175.94414.3329397906722546895.b4-ty@b4>
References: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 09 Jul 2026 12:12:31 +0530, Shubham Patil wrote:
> This patch series introduces support for the AMD I3C master controller,
> including the device tree binding and driver implementation.

Applied, thanks!

[1/2] dt-bindings: i3c: Add AMD I3C master controller support
      https://git.kernel.org/i3c/c/56cffc20a329
[2/2] i3c: master: Add driver for AMD AXI I3C master controller
      https://git.kernel.org/i3c/c/7e05871da7ac

Best regards,
