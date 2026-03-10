Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9D279DCA;
	Tue, 10 Mar 2026 21:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177102; cv=none; b=X+m2/SOnTEkNTLQXpie88OMYdAdX04i34k14v7xpxdgvqs5joVY8o5rQkMJcAmAbGMPwJQXKtM4NPh/Zb1Ob6ufXuoVQ+/eP8/44xT8idjH2uLb8hAkMXUJNgB3XYCoWazQSlNMxSSklOTCSTvzQCyKHqnyRPDtYELGeUT4lxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177102; c=relaxed/simple;
	bh=u9D4qSIhsqbHAEaJC+KfjGBC0/+qWnDd2jVHhVc12Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx2rFt3b+90O5lV8X381fLwte3nxWA/TApYzWWWiRPu5LSijmYotmW4AaGidLOJWEcM+t1/kXhR2N3Xlg3Ufm1+lzkNR1837S8pECgflZ76gQ3ZWpOYGhvve0HUMz/QakeW3E6iUItz/J55I9pH2KyqPiCztMFbmewI5yieKqGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH0SHwW2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH0SHwW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD220C19423;
	Tue, 10 Mar 2026 21:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773177102;
	bh=u9D4qSIhsqbHAEaJC+KfjGBC0/+qWnDd2jVHhVc12Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VH0SHwW2EakhuoAOlXnHVG/DOFMds3YD5l8iS+OsAyWWfAno1uHNcQOkOsZg89/vB
	 sz5gNWAqBUEneU4LKkjUrzRVARqs1112fvzBRDiOMYdvrEyNWjGXJ6Bvwdq/acoFSA
	 U6+LmcJGgJFC49mosiJc7sTvP3V+uiVO16/Txt+eHELFQICkwZm983kOdwv6Q1QWkP
	 y1OsGkdoUhwWPrrrb49qHzB2wtjJR3fPEyAnzxNnHFX3G+dAbwuLypQ1jQusvNgUwh
	 hDA7v1J8dkw8hcBMyAzbwpeQZyNRNVBZWNOw+MGNxQJA/oBWuskHTU40OJv/9zXKlJ
	 g19Oq0oWIxXSg==
Date: Tue, 10 Mar 2026 14:11:39 -0700
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
Subject: Re: [PATCH v4 03/17] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
Message-ID: <20260310211139.GB120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-3-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-3-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:47PM +0100, Thomas Weiﬂschuh wrote:
> When configuration settings are disabled the guarded functions are
> defined as empty stubs, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the checks avoids some later churn.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  security/integrity/ima/ima_efi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
