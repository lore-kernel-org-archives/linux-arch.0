Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A43B0AE5;
	Tue, 10 Mar 2026 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177129; cv=none; b=D4OO6mx9lcpwIwYxNcplB9kw6+KFqUm0yR++CLBONbAqOLNaseKRp3x8cGsvQI0BTJfOwUYI/sA3w50CDU+zEoeDDCZV7WazexIRwvpEEB3SIIje9XR7pOPuUaQHdqQz4c4OHi+3gCQQ/GI+/ENz6DvUFNbLT1GzwKXRPVnmgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177129; c=relaxed/simple;
	bh=I0hRXA8vzphZyPkmaTEi2UnR4I9riSViZx4ZP8KHRbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRuK3iwgcc02saHxWB1zAgdy0skPKVkQ6mjqh8aDqzZEAhQBOHCk8WJSuXswtebUwnYDHjoNQJ7FkAeulqRe95oOR/5vqHYctgO9azZu67IT2Ik0zWvSNWRaLdylqRmKamKM8h009qloNKDcuG6OXabAFtnFqfz8jFF8rtRmxlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7fKUptr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7fKUptr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE8FC19423;
	Tue, 10 Mar 2026 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773177128;
	bh=I0hRXA8vzphZyPkmaTEi2UnR4I9riSViZx4ZP8KHRbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7fKUptrVOBNk+lqoq2TGcmqzyyjfveB/G4PfGYInXiYCctySVHzOBa/UUoB33G61
	 MmJGLpJ+mo49MHhJD6aD1XApq+fSFdW/dHzoHTjOMiz6fetsczx/N6BP3wKmhjYRuT
	 drpMGbJM9ukEMtNJyyFHtTD1ePlkUiafmvvtZN8JT6pAdwRYXD3+cTaqX/42GtCJ1E
	 MMafX+lc4Ql0IAOp4t5FyN5fUaWaw2pCHhQjKDELAQ8Pik3Iut0hg+Bx85zMaVSQmQ
	 vMGEHIo5jDcg8mMPiODtqCIvJhPlv0kMQVWgJKmRw9pF1k6OP3TUMj8/1LakJ/MrPO
	 UqlCpZx+AHtog==
Date: Tue, 10 Mar 2026 14:12:05 -0700
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
Subject: Re: [PATCH v4 04/17] module: Make mod_verify_sig() static
Message-ID: <20260310211205.GC120274@quark>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-4-0b932db9b56b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113-module-hashes-v4-4-0b932db9b56b@weissschuh.net>

On Tue, Jan 13, 2026 at 01:28:48PM +0100, Thomas Weiﬂschuh wrote:
> It is not used outside of signing.c.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  kernel/module/internal.h | 1 -
>  kernel/module/signing.c  | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
