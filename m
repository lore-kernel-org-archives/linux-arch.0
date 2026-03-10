Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2273A3802;
	Tue, 10 Mar 2026 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177070; cv=none; b=YDdWS7wfkRpxyvj40GAVUl2t4XA8OC8hoIwiRS6BfV0pibpcAPu79KX4htl+7fshiQxXqFfvFc18/JgJCFkBnf5l/4RSVQRYZXFE9xjmlkCPZiRSnAvT2lzs5DaqTa/JjBU1TihNYz8gXea6cpYB64PB+ulxP0dAHitMIBVW4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177070; c=relaxed/simple;
	bh=yyzdGp+0sPRPTiABz81aZRloIPxSgjyHr2YQUr/A+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU+jP/yzwI215TxeFGYdWePmDYqzCfC/22QBIL2AIQaBAAgksJP8v1x56Gnw98g+9wCmjFaR+kGNd/QoONG2Fw/0Wlas8dgbBqUezdtCg0sbYuM5DTgBKJJlECxJO/YS2JKvuFmlR4ARAqvNVe16s73KnF2FPzKHBW3TE/AuL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFYD1ByL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFYD1ByL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E792DC19423;
	Tue, 10 Mar 2026 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773177069;
	bh=yyzdGp+0sPRPTiABz81aZRloIPxSgjyHr2YQUr/A+N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dFYD1ByLLsnPqMH8HvpxcPSYDZmiTMH9uIgAC5+zFHLZxBhpolkrX+vcWCFVr8dmj
	 29js3lSD3EP6jNZyT+AW/TyMOyiweLB8zLOj+u1rKJO+Yk5G4k4INqFDRribqkQwYG
	 PU5Sqe0GLid9VxVNNxx6J7CXuJfFQ3+3PM3bfGXpngtw1jEkAz3zyt3foM96dA+4PA
	 gNPBVPESP3sZ2w5NQjwiuGdGIuRenZrAmo8N1lZ2ElCPuIwn9/4e2+Fy9uJ3qTwYGb
	 FUBKESjL6+R7Ljy++ot4ShKUaVNg5AnAT+CWS1XDngm6viJftDOM2Y43c8qq4sW242
	 w6uDBPIYTGkYQ==
Date: Tue, 10 Mar 2026 14:11:06 -0700
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
Subject: Re: [PATCH v4 02/17] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
Message-ID: <20260310211106.GA120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-2-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-2-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:46PM +0100, Thomas Weiﬂschuh wrote:
> When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
> as an empty stub, so the check is unnecessary.
> The specific configuration option for set_module_sig_enforced() is
> about to change and removing the check avoids some later churn.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  arch/powerpc/kernel/ima_arch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
