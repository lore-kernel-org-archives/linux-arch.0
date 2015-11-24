From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Kbuild: disable 'maybe-uninitialized' warning for
 CONFIG_PROFILE_ALL_BRANCHES
Date: Tue, 24 Nov 2015 11:42:09 +0100
Message-ID: <20825812.L9y0yMCgts@wuerfel>
References: <3799453.oCg1CdOrtm@wuerfel> <565439FB.6050800@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <565439FB.6050800@suse.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Michal Marek <mmarek@suse.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 24 November 2015 11:20:43 Michal Marek wrote:
> > diff --git a/Makefile b/Makefile
> > index 5e01a416c6e4..f8b921658f29 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -626,7 +626,11 @@ KBUILD_CFLAGS    += $(call cc-option,-fno-delete-null-pointer-checks,)
> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> >  KBUILD_CFLAGS        += -Os $(call cc-disable-warning,maybe-uninitialized,)
> >  else
> > -KBUILD_CFLAGS        += -O2
> > +ifdef CONFIG_PROFILE_ALL_BRANCHES
> > +KBUILD_CFLAGS        += -O2 $(call cc-disable-warning,maybe-uninitialized,)
> > +else
> > +KBUILD_CFLAGS   += -O2
> > +endif
> 
> Does it only happen with -O2? Normally, we would add it outside the
> ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 

We already disable the warning for -Os builds based on a patch we merged
a while ago. It seems easier to add it to the block we already have.

	Arnd
