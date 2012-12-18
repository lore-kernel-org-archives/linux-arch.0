From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/7] move debugfs to filesystems menu (fs/Kconfig)
Date: Mon, 17 Dec 2012 18:21:30 -0800
Message-ID: <20121218022130.GA16839@kroah.com>
References: <20121217182206.91AA150A@kernel.stglabs.ibm.com>
 <20121217182207.4CF51258@kernel.stglabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121217182207.4CF51258@kernel.stglabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 17, 2012 at 01:22:07PM -0500, Dave Hansen wrote:
> 
> debugfs may have started out as a kernel hacking kind of option.  But,
> today, it is an integral part of lots of facilities like tracing that
> are far from kernel hacking.  Let's move it out of the very cluttered
> "Kernel Hacking" menu and but it next to its real family: other
> filesystems like sysfs, configfs, or /proc.
> 
> Also, "Debug filesystem" sounds like a debugging option _for_
> filesystems code, not a filesystem for debugging.  We also never call
> it "the debug filesystem."  We always say "debugfs", so reflect the
> fact that we _call_ it debugfs in the menu text.
> 
> Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
