From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Request for unicore32 architecture codes to merge into linux-next
Date: Sat, 15 Jan 2011 14:08:09 -0800
Message-ID: <20110115220809.GC19872@core.coreip.homeip.net>
References: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <004901cbb4d5$b9bb1370$2d313a50$@mprc.pku.edu.cn>
Sender: linux-next-owner@vger.kernel.org
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: sfr@canb.auug.org.au, Arnd Bergmann <arnd@arndb.de>, gregkh@suse.de, jbarnes@virtuousgeek.org, rubini@cvml.unipv.it, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-next@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

On Sun, Jan 16, 2011 at 01:00:31AM +0800, Guan Xuetao wrote:
> Hi,
> 
> I want to merge unicore32 repo into linux-next tree, the position is (unicore32 branch):
>   git://git.kernel.org/pub/scm/linux/kernel/git/epip/linux-2.6-unicore32.git
> 

Have these changes been reviewed at all? Looking at the input parts I
doubt it... We try _really_ hard to avoid sprinkling arch #ifedefs in
the common code.

So, for input:

- how big is the difference between standard keytable and the one you
  are introducing? Looks like you are just adding 5 new keys that are
  not critical for booting. So please just update keymap from userpsace
  as we do for countless laptops and keyboards out there.

- Trying to enable mouse 1000 times can lead to loooong delays. Have
  you tried to figure out why you need the loop?

- What kind of mice can be connected to teh devices? I am concerned that
  your super-strict protocol checks will cause more harm then good (i do
  not believe they are valied in general case, overflow is just and
  additional bit).

Please split changes related into logically separated patches and post
them on linux-input@vger.kernel.org (along with linux-kernel if you
prefer) for review and comments.

Thanks.

-- 
Dmitry
