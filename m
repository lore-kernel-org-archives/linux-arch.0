From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Turn CONFIG_STRICT_DEVMEM in sysctl
	dev.mem.restricted
Date: Sun, 16 Nov 2008 17:03:06 +0000
Message-ID: <20081116170306.5b3bc30a@lxorguk.ukuu.org.uk>
References: <1226846868-9595-1-git-send-email-bwalle@suse.de>
	<20081116150756.3cece2de@lxorguk.ukuu.org.uk>
	<20081116162003.04267538@kopernikus.site>
	<20081116154541.1f196f1e@lxorguk.ukuu.org.uk>
	<20081116171139.0456b1b2@kopernikus.site>
Reply-To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <crash-utility-bounces@redhat.com>
In-Reply-To: <20081116171139.0456b1b2@kopernikus.site>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/crash-utility>
List-Post: <mailto:crash-utility@redhat.com>
List-Help: <mailto:crash-utility-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/crash-utility>,
	<mailto:crash-utility-request@redhat.com?subject=subscribe>
Sender: crash-utility-bounces@redhat.com
Errors-To: crash-utility-bounces@redhat.com
To: Bernhard Walle <bwalle@suse.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, crash-utility@redhat.com
List-Id: linux-arch.vger.kernel.org

> > Which also doesn't explain what this turd is for.
> 
> Could we discuss more factual without words like "turd", please?

What else would you have me call it. It's junk.

> > The functionality provided by STRICT_DEVMEM is the same with it on or off
> > - absolutely *nothing*.
> 
> Even with SELinux?

As far as I can tell yes, and certainly with vendor shipped rulesets.

> > does compile it *out* and the overhead is gone totally for the many
> > embedded and other devices that don't use it.
> 
> For SELinux, yes. 

And for strict devmem but only before your patch.

> Oh well, I don't tell it our legal people if you would write SuSE
> instead of SUSE. Even not S.u.S.E. ;-)

Hehe ;)

> Well, if you let the CONFIG option there and only add the sysfs entry
> it does not. Even most embedded stuff is not x86.

These days a large amount of embedded is x86 and this is growing.

> > Even if you want to turd polish there are cleaner solutions. A process
> > with CAP_SYS_RAWIO can cheerfully bypass any restriction you try and
> > place so you could rip out all the sysctl crap and just say that
> > the /dev/mem restriction doesn't apply to a CAP_SYS_RAWIO process.
> 
> According to Arjan that does not work.

According to me CONFIG_STRICT_DEVMEM does not work either. Looking at the
X code most of it now tries really hard to use the right device files and
accesses. The window that is left is primarily the old ISA VGA hole and
even that could better be solved with a /dev/vgamem or similar that X
could use rather than /dev/mem.

Alan
