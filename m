Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40982DCF46;
	Fri,  6 Feb 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770368159; cv=none; b=IUoJ4GwVBykvOe4hrQTz7S3fWvaf8RS+XgP4nToCAoFKJ+Mk+oNnwZqiSx01N2o6qqnlCcIuI61+i0oChmzPidynKPqqddFaIRmL/qndURc0cf2m74IJjDQE4DuBWl9FT5oZ39fu59q4kXNEPsE9njnnZfG2IxpMeZrbi1Fqqyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770368159; c=relaxed/simple;
	bh=TUSlCOhrAtGm3RFLHWsHhAz5xYWCAH3aTOWbzoQrEko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpt6njdTFt5ooJYS2GgUbGTRWzngfkcaiOcBlOTLdsmO8z4bvHyYBe/vyx9TRc+6f9GPXBwwpAm94ahcTHGm8W3AqLP3uDyNLCj7flQgPzghtPGA1iyZ200VMBpNnTWf4P++KL9zIXcHPlVlIJOpQ8cHRx26E+/Le+ghtYwrEUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CU+cP+w0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CU+cP+w0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB60C116C6;
	Fri,  6 Feb 2026 08:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770368159;
	bh=TUSlCOhrAtGm3RFLHWsHhAz5xYWCAH3aTOWbzoQrEko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CU+cP+w07aDAn1kC18HiM/LUIeZUCnNuHh0PfQQjZjmj3J0A4fhIhk05I3vcnbasd
	 rNcR+4z2piSJJtZzQRuZKltlh8lIbnQDc7tx+z9+Pj8QKcCl3Y/gKJpBnusjZdTBvW
	 7QUz3JlqWwj040I5c4Nyw23/DajuxfO/OQltgGyNxuUWczbwHSMYQGS3vSw+BHPIqm
	 nm2McVRUpJg5wNG2K/L9kZx0wix2DyCr04JIcSh0FtTKv9YYnTDOAYOHxfUNaYnb32
	 O3K3fvUKrO75FiWXaYvRFpf++ADHPckHazTjaBAIpUzhBH3CkXh8NkSnmWvBZYJZ+/
	 ebMCmVyMQHjgA==
Date: Fri, 6 Feb 2026 09:55:50 +0100
From: Nicolas Schier <nsc@kernel.org>
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
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
Subject: Re: [PATCH v4 05/17] module: Switch load_info::len to size_t
Message-ID: <aYWsllH6SIl4Yik4@derry.ads.avm.de>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
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
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-5-0b932db9b56b@weissschuh.net>
 <aYWmkEzjvo9RrzI9@levanger>
 <8fd4914d-5cff-4030-822c-98c8e76d0e60@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd4914d-5cff-4030-822c-98c8e76d0e60@t-8ch.de>

On Fri, Feb 06, 2026 at 09:38:07AM +0100, Thomas Weißschuh wrote:
> On 2026-02-06 09:30:08+0100, Nicolas Schier wrote:
> > On Tue, Jan 13, 2026 at 01:28:49PM +0100, Thomas Weißschuh wrote:
> > > Switching the types will make some later changes cleaner.
> > > size_t is also the semantically correct type for this field.
> > > 
> > > As both 'size_t' and 'unsigned int' are always the same size, this
> > > should be risk-free.
> > 
> > include/uapi/asm-generic/posix_types.h states:
> > | * Most 32 bit architectures use "unsigned int" size_t,
> > | * and all 64 bit architectures use "unsigned long" size_t.
> > 
> > Is that statement wrong?  Or did I mix up the context?
> 
> That statement is correct. But as both 'unsigned int' and 'unsigned
> long' are 32-bit wide on 32-bit Linux platforms they are compatible.
> 
> 
> Thomas

sure, thanks!

Acked-by: Nicolas Schier <nsc@kernel.org>

-- 
Nicolas
