Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034912D77E9;
	Wed, 11 Mar 2026 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233899; cv=none; b=ah23GgkQ8r8EJCXe/3YDK+RM0aCqNSFMUm+E/wWO08b2aD4JLhuRpXZ0QacM3V7l+IvemFw6sFQPs/0ndC9AWPfZWZxA5acuL/2MCgqIveMV5e/c4AkJM+61hROGpBtGN10w+LS9vr2d/kaG75h3r68AexdJt4If8vfSFONEXoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233899; c=relaxed/simple;
	bh=mRn/wE2BOJdmVXtetURpi3qdtZ2DQzJb6SnV9QqyjkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkpxTzlrx8dOT03xldKIH5NGSJDK2wIvCukbd+VbiCiQYD1G9dC9HCZwHlxDqoLfG8MerP6Ws8kca5140X6a6EPd7mPvYbxOhdGU5KnaodmHwio4VFf1geLumsq/GHQX9bHMhyaIPHyJ5BM9K7bq/Cj4QYtD5MQSQuQv36FxM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=k90soJZP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="k90soJZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1773233887;
	bh=mRn/wE2BOJdmVXtetURpi3qdtZ2DQzJb6SnV9QqyjkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k90soJZPKmK3WO0aN0btxQNxuBpFawAlVAt8Y/y5iCKKutCz/URHVI6erF06qEnJb
	 UErb09oCmFeFT4NoInvtsQ57j4bPe83GaAnwXmLf73CWGB4LgUkwkKHVTuqOzhv039
	 l997WH4HQ39CRI7rjR0x4LOMudFJrvf8taL+1xCg=
Date: Wed, 11 Mar 2026 13:58:07 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
	=?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 06/17] kbuild: add stamp file for vmlinux BTF data
Message-ID: <cf122165-ebf3-4027-aa31-a37755eb352f@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-6-0b932db9b56b@weissschuh.net>
 <20260310213606.GD120274@quark>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310213606.GD120274@quark>

On 2026-03-10 14:36:06-0700, Eric Biggers wrote:
> On Tue, Jan 13, 2026 at 01:28:50PM +0100, Thomas Weißschuh wrote:
> > The upcoming module hashes functionality will build the modules in
> > between the generation of the BTF data and the final link of vmlinux.
> > Having a dependency from the modules on vmlinux would make this
> > impossible as it would mean having a cyclic dependency.
> > Break this cyclic dependency by introducing a new target.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  scripts/Makefile.modfinal | 4 ++--
> >  scripts/link-vmlinux.sh   | 6 ++++++
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 149e12ff5700..adfef1e002a9 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -56,8 +56,8 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
> >  	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> >  
> >  # Re-generate module BTFs if either module's .ko or vmlinux changed
> > -%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
> > -	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
> > +%.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/.tmp_vmlinux_btf.stamp) FORCE
> > +	+$(call if_changed_except,ld_ko_o,$(objtree)/.tmp_vmlinux_btf.stamp)
> >  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> >  endif
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 4ab44c73da4d..8c98f8645a5c 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -111,6 +111,7 @@ vmlinux_link()
> >  gen_btf()
> >  {
> >  	local btf_data=${1}.btf.o
> > +	local btf_stamp=.tmp_vmlinux_btf.stamp
> >  
> >  	info BTF "${btf_data}"
> >  	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> > @@ -131,6 +132,11 @@ gen_btf()
> >  	fi
> >  	printf "${et_rel}" | dd of="${btf_data}" conv=notrunc bs=1 seek=16 status=none
> >  
> > +	info STAMP $btf_stamp
> > +	if ! cmp --silent $btf_data $btf_stamp; then
> > +		cp $btf_data $btf_stamp
> > +	fi

This patch will be gone from the next revision of the series.
Making use of the recently introduced vmlinux.unstripped,
as suggested by Petr, removes any modifications to link-vmlinux.sh
and the issue that this patch tried to address.

> A "stamp file" is traditionally an empty file that is written when some
> build step has completed.  The above code is instead copying the entire
> .tmp_vmlinux1.btf.o file (megabytes in size) to .tmp_vmlinux_btf.stamp.

The goal here was not to only have a reference timestamp, but
specifically the reference file contents.

Note: The duplicated vmlinux.unstripped in its current form is by far
larger than .tmp_vmlinux1.btf.o.

> So, it's not clear to me why the stamp file is needed at all, versus
> depending directly on .tmp_vmlinux1.btf.o.
>
> I guess 'make' doesn't know about the dependencies of
> .tmp_vmlinux1.btf.o.  But the same is true of the stamp file, right?  So
> either way, how would 'make' know to finish rebuilding the file before
> starting to execute the "Re-generate module BTFs" rule?

The problem was not the ordering, this is handled within link-vmlinux.sh.
IIRC originally without this patch even no-op rebuilds would end up
rebuilding the modules. Using .tmp_vmlinux1.btf.o may have worked too.
But in v4, the patch "kbuild: generate module BTF based on
vmlinux.unstripped" was added, which also solves this problem.

> Also, passing the long option '--silent' to 'cmp' creates a dependency
> on the GNU implementation of 'cmp', which isn't documented as a kernel
> build dependency.  Probably better to use the short option '-s'.

Ack.

> Also, the stamp file isn't being deleted by 'make clean'.  It looks like
> it would need to be added to cleanup() in link-vmlinux.sh.

Ack.


Thomas
