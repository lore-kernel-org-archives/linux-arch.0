From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 09/10] usb-storage: remove single-use define for
 debugging
Date: Tue, 13 Aug 2019 15:12:48 +0200
Message-ID: <20190813131248.GB16399@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-10-maennich@google.com>
 <20190813124259.GC14284@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190813124259.GC14284@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Maennich <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, maco@android.com, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sboyd@codeaurora.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 13, 2019 at 02:42:59PM +0200, Greg KH wrote:
> On Tue, Aug 13, 2019 at 01:17:06PM +0100, Matthias Maennich wrote:
> > USB_STORAGE was defined as "usb-storage: " and used in a single location
> > as argument to printk. In order to be able to use the name
> > 'USB_STORAGE', drop the definition and use the string directly for the
> > printk call.
> > 
> > Signed-off-by: Matthias Maennich <maennich@google.com>
> > ---
> >  drivers/usb/storage/debug.h    | 2 --
> >  drivers/usb/storage/scsiglue.c | 2 +-
> >  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> I'll go take this today.  The module really should just be using
> dev_err() there.  It needs to be cleaned up :(

Now applied to the usb git tree, thanks.

greg k-h
