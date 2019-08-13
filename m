From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/10] module: support reading multiple values per
 modinfo tag
Date: Tue, 13 Aug 2019 14:40:57 +0200
Message-ID: <20190813124057.GA14284@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-2-maennich@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-2-maennich@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Maennich <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, maco@android.com, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sboyd@codeaurora.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 13, 2019 at 01:16:58PM +0100, Matthias Maennich wrote:
> Similar to modpost's get_next_modinfo(), introduce get_next_modinfo() in
> kernel/module.c to acquire any further values associated with the same
> modinfo tag name. That is useful for any tags that have multiple
> occurrences (such as 'alias'), but is in particular introduced here as
> part of the symbol namespaces patch series to read the (potentially)
> multiple namespaces a module is importing.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
