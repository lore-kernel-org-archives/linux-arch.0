From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/2] proc: convert everything to "struct proc_ops"
Date: Mon, 6 Jan 2020 18:17:25 +0300
Message-ID: <20200106151725.GB382@avx2>
References: <20191225172228.GA13378@avx2>
 <20191225172546.GB13378@avx2>
 <20191231150121.5b09e34205444f6c65277b73@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191231150121.5b09e34205444f6c65277b73@linux-foundation.org>
Sender: netdev-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 31, 2019 at 03:01:21PM -0800, Andrew Morton wrote:
> On Wed, 25 Dec 2019 20:25:46 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > The most notable change is DEFINE_SHOW_ATTRIBUTE macro split in
> > seq_file.h.
> > 
> > Conversion rule is:
> > 
> > 	llseek		=> proc_lseek
> > 	unlocked_ioctl	=> proc_ioctl
> > 
> > 	xxx		=> proc_xxx
> > 
> > 	delete ".owner = THIS_MODULE" line
> > 
> > ...
> >
> >  drivers/staging/isdn/hysdn/hysdn_procconf.c           |   15 +-
> >  drivers/staging/isdn/hysdn/hysdn_proclog.c            |   17 +-
> 
> These seem to have disappeared in linux-next.

Excellent, the less chunks the better.
Any actual conversion can be dropped if file was deleted.
