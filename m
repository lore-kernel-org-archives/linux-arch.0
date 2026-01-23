Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE252DC763;
	Fri, 23 Jan 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183072; cv=none; b=XayqSarQtxL4G2TH+S/F/P6jY4a7bFwckXryoVM5rBGjshm3wHIsMwM6/pzpzUtQwUDbZEbW5KirNdhz3eiNWYQvEWwHEHpvvQ/NZ/s4O7IIy7nXXpkDINe83RPzcxQBaamwnF6l+KOokggYQ2qQNIhdYPXNwPSHROzQFKbh5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183072; c=relaxed/simple;
	bh=PI8U66nkmI69uDjXwlGAwVg6sJc6HZyC/Sm7bA+TuPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiwNeGorNM9/D6QW2eCdfWaxIqodHm20rriclOqjY/hiRv6vM1JLQvU0n3EkuIHKW6jX7F1jQGt/Z3Yh6HXg/SPlZzW259mPdcTZhyKh2KjVMjHL82kdwO6/vTo3a/IRghgmVJ6YJmRduuy9L19/FoL0Gy2i3EgoGJs8y3+B/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDb2KnuG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDb2KnuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A56FC4CEF1;
	Fri, 23 Jan 2026 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769183071;
	bh=PI8U66nkmI69uDjXwlGAwVg6sJc6HZyC/Sm7bA+TuPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDb2KnuGFQseZTkYNhCLW0+KaPv0xP4e3UdVruFz1cgmC8r6RE/BJbSDVAxEtkGWa
	 dSZ555ljpCwkFMymZNUwLWWSWiHE9Fkz362nOBD55WjdCrKADVKRQbq/ncxuk5ht6G
	 3y+40sVU5blFOUYHqw9LJEM2MNe3PLs/D5O8f/y/12Udkn+lsvzyZ5ur/wvMFFuvVW
	 8LdPLBtvWP4dudWVq3ee5q4u/nBnk5yDI8b6F32rcry2pa/Eou9/eUcauk1UZbEpHl
	 tdkfWoFlLciqeaa0tBVa6rT8SAuZODab0tU/N5lu+RF9orDfQf54W11dweJA/vokLw
	 tDyTWCT7oDXlA==
Date: Fri, 23 Jan 2026 15:44:25 +0000
From: Simon Horman <horms@kernel.org>
To: david.laight.linux@gmail.com
Cc: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH next 05/14] ixgbevf: Use C test for PAGE_SIZE >
 IXGBE_MAX_DATA_PER_TXD
Message-ID: <aXOXWWH7je3VKMn6@horms.kernel.org>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-6-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-6-david.laight.linux@gmail.com>

On Wed, Jan 21, 2026 at 02:57:22PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Compile-time tests being added to BIT() make it an 'integer constant
> expression' rather than a pre-processor expression for W=1 builds.
> 
> This means BIT() can't be used in pre-processor conditional that
> checks 'PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD'.
> Change to use a normal 'if' statement, the compiler will optimise
> away the unwanted code.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Thanks David,

Other than the motivation above, I appreciate that this removes two
#ifdefs, improving readability (subjective) and compile coverage
(objective) of this code.

As an aside: I'm Not sure what your merge plan is for this patchset, and
only it and the cover letter hit my inbox, so I'm missing context.  But
from a Networking PoV it seems that it could be sent as a stand-alone patch
to the iwl tree.

Regardless, feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>

...
