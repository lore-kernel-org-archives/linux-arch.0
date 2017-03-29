From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] percpu: drop useless macro PER_CPU_DEF_ATTRIBUTES
Date: Wed, 29 Mar 2017 11:28:27 -0400
Message-ID: <20170329152827.GB30385@htj.duckdns.org>
References: <1490690107-30009-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <20170328160040.GC28157@htj.duckdns.org>
 <58DB1E19.4020501@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <58DB1E19.4020501@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, cl@linux.com
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 29, 2017 at 10:38:17AM +0800, Cao jin wrote:
> On 03/29/2017 12:00 AM, Tejun Heo wrote:
> > On Tue, Mar 28, 2017 at 04:35:07PM +0800, Cao jin wrote:
> >> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> > 
> > I'm not sure.  I think I used it during development and it's not like
> > it costs anything to keep.
> 
> It easily confusing newbies without any comments for its purpose.

percpu variable handling is pretty complex to begin with.  I don't buy
that an empty default attribute macro adds anything noticeable there.

> Temporary using during development seems not good to persist. Could I
> know its purpose?

I don't remember the exact details but at the same time I don't see
the value of the proposed change.  We can apply or not apply the patch
and either way wouldn't make any noticeable difference.  What's the
point?

Thanks.

-- 
tejun
