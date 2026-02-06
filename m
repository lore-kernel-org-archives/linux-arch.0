Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F082329E53;
	Fri,  6 Feb 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770396052; cv=none; b=kVhEYJNWLxlrP7EZBzvYEV2qCpEUg3MXm6+SkRw0u/I5YIp1PcmHgzZFMM6h/UbxPOLwLvky6Qe7n5w0u49mR6DbDMhqnMU/v4h63pjkVrDAVvq4Zvw60bsTWZWCDkbA68mz6MESnaV8MsJ6OI7WB9weLlFahXo6O/ARSQXqv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770396052; c=relaxed/simple;
	bh=OjlPJKal/r/xktrObWF4EN+W4fuERCVz3klo7EziBEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoNwNy54tREpZ1teCvNRCXeplOvxPMDFLK848wtIswl4b1hWhnPTaTkjLQUEKsXMfEB9axuV77YEiPeY57mKP6ufoTEsKhFxLoysWTHwNnyTOd+wxG0sHmQmiUk8do+jgmd//hkHqdRqWulsGUAb4k5IGbeD+qv5RxbJ3DjU2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIH2NESO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIH2NESO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ECDC116C6;
	Fri,  6 Feb 2026 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770396052;
	bh=OjlPJKal/r/xktrObWF4EN+W4fuERCVz3klo7EziBEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FIH2NESOpXVNtlsSPOGEvXUlIr8NT0wIDfGRfc1bk+sPGjdRpSfsSTlY77gAT017B
	 pDMgsPGn7HM6G8E87LjlTTI3lgCl6kFmDgi3YJcUbZ2khhGki0oM8bR3itauRubqjA
	 ncOqK4PJdbq/ogiMPom7Tak80clT69VqTtSSeVjXvyoh25+n3r8P0AQZFkmFRBXtu1
	 rLtI31y0YJ0Xs7/etvJiILp/OUjG/c2vXek8MdRS21VJxswsocPhGCgtJpj0duPNdW
	 /EpU+4R3zkXnDNgvg2GnUqYK1pn88YOBzSTDmMoEyyQZf3EmgQ62akVoY4ixn6Ml+X
	 EWeAMoP9M82QQ==
Date: Fri, 6 Feb 2026 17:37:01 +0100
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
Subject: Re: [PATCH v4 07/17] kbuild: generate module BTF based on
 vmlinux.unstripped
Message-ID: <aYYYrcCv7ncfGyg-@levanger>
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
 <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:51PM +0100, Thomas Weiﬂschuh wrote:
> The upcoming module hashes functionality will build the modules in
> between the generation of the BTF data and the final link of vmlinux.
> At this point vmlinux is not yet built and therefore can't be used for
> module BTF generation. vmlinux.unstripped however is usable and
> sufficient for BTF generation.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  scripts/Makefile.modfinal | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index adfef1e002a9..930db0524a0a 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -40,11 +40,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>  
>  quiet_cmd_btf_ko = BTF [M] $@
>        cmd_btf_ko = 							\
> -	if [ ! -f $(objtree)/vmlinux ]; then				\
> -		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
> +	if [ ! -f $(objtree)/vmlinux.unstripped ]; then			\
> +		printf "Skipping BTF generation for %s due to unavailability of vmlinux.unstripped\n" $@ 1>&2; \
>  	else								\
> -		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
> -		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
> +		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux.unstripped $@; \
> +		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;	\

Reviewed-by: Nicolas Schier <nsc@kernel.org> # kbuild

I'd like to have some BTF ack for that.

-- 
Nicolas
