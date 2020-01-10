From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v2 00/10] Impveovements for random.h/archrandom.h
Date: Fri, 10 Jan 2020 12:05:59 -0500
Message-ID: <20200110170559.GA304349@mit.edu>
References: <20200110145422.49141-1-broonie@kernel.org>
 <20200110155153.GG19453@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200110155153.GG19453@zn.tnic>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, x86@kernel.org, Richard Henderson <richard.henderson@linaro.org>, Mark Brown <broonie@kernel.org>, linux-crypto@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 10, 2020 at 04:51:53PM +0100, Borislav Petkov wrote:
> On Fri, Jan 10, 2020 at 02:54:12PM +0000, Mark Brown wrote:
> > This is a resend of a series from Richard Henderson last posted back in
> > November:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20191106141308.30535-1-rth@twiddle.net/
> > 
> > Back then Borislav said they looked good and asked if he should take
> > them through the tip tree but things seem to have got lost since then.
> 
> Or, alternatively, akpm could take them. In any case, if someone else
> ends up doing that, for the x86 bits:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>

Or I can take them through the random.git tree, since we have a lot of
changes this cycle going to Linus anyway.  Any objections?

	     	   	    	  	   - Ted
