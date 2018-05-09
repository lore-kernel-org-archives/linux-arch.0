From: "Du, Changbin" <changbin.du@intel.com>
Subject: Re: [PATCH v3 2/5] regulator: add dummy function
 of_find_regulator_by_node
Date: Wed, 9 May 2018 16:13:42 +0800
Message-ID: <20180509081341.ahx7xuqs366gmqaf@intel.com>
References: <1525566016-30172-1-git-send-email-changbin.du@intel.com>
 <1525566016-30172-3-git-send-email-changbin.du@intel.com>
 <20180509082114.GQ13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180509082114.GQ13402@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 09, 2018 at 05:21:14PM +0900, Mark Brown wrote:
> On Sun, May 06, 2018 at 08:20:13AM +0800, changbin.du@intel.com wrote:
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > If device tree is not enabled, of_find_regulator_by_node() should have
> > a dummy function since the function call is still there.
> 
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.

Hmm, I saw your merging notification too late. Let me refresh the series. Sorry
for confusing.

-- 
Thanks,
Changbin Du
