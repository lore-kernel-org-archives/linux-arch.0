Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C03EAC91;
	Tue, 10 Mar 2026 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180374; cv=none; b=t6VUEkieXgSLdOuagcfRiueYoh5qvB2g+cWO1sWwZ2zUI8tYQCG/1lAzvcMRsveaWxuk8Dl6yCFY8ovsL8OHt/qmoZ7hQbmCN8cwBqBuPGgn57O51mkbkS1689ioYlXSpq2kGSKtam8E8s5ToBaBrepq0Gck0JUY3IAB965H5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180374; c=relaxed/simple;
	bh=Z2giByPPRkEFQ5qLqYmDyLPdv5AowAZxy5PkqD3GqNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaETqHquIKE1XVHtg10scAUtaUzWPUvx+izrwEiV5jV6TvLhA7xKNnBM61wTb8bT7EAfu4Hal1g4W4uO1fPafICsVxN4O+L4nCchtBeRMjXnPwXyc9HrLScbZfL1aAHYmI0rHvb67J83T0ZMcQJOmEM95ZqsLTGjnDPsIVJwTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niMNHIJg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niMNHIJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FEEC19423;
	Tue, 10 Mar 2026 22:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773180374;
	bh=Z2giByPPRkEFQ5qLqYmDyLPdv5AowAZxy5PkqD3GqNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=niMNHIJgC+Fz1U3WEaHZP1AZ6A6ndoOiIOXNnbFOQJsdOYzSy3crlWDdkLKjeR5b2
	 XvH4lmIKveB2sp9jzY5WkaDtkmeDQejcg4IoTi7DNKUO4WaucUDLPOcBnVCGS1QaHH
	 ICRtc+Db7OW7Hf/vBq/22p+5js/WsiX+rFyr51i3UUtyH2VXaO0tDFHxTHghJbweVK
	 i+CrRjzWn8CB8fcmxJoA7FgucAgGM6YYIdwLcXufx7WeQLdm6py7P49e5bjDU/9vu1
	 /yJPj/0yLUiv46KoZXKcBlDm0/zuidupWpweJ0iRXBwOexeMyAnrcoUyEaC0VC8aoU
	 LxihD60Qr2aPA==
Date: Tue, 10 Mar 2026 15:06:11 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 10/17] module: Move integrity checks into dedicated
 function
Message-ID: <20260310220611.GF120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-10-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-10-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:54PM +0100, Thomas Weißschuh wrote:
> +static int module_integrity_check(struct load_info *info, int flags)
> +{
> +	int err = 0;
> +
> +	if (IS_ENABLED(CONFIG_MODULE_SIG))
> +		err = module_sig_check(info, flags);
> +
> +	return err;
> +}

Maybe module_authenticity_check()?  The purpose is authenticity, not
merely integrity.

- Eric
