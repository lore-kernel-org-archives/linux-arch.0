From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v11 00/19] Re-introduce h8300 architecture
Date: Fri, 8 May 2015 11:54:49 -0700
Message-ID: <20150508185449.GA1970@roeck-us.net>
References: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431097479-21101-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, May 09, 2015 at 12:04:20AM +0900, Yoshinori Sato wrote:
> Hello.
> I will re-introducing h8300.
> 
[ ... ]
> 
> git repository
> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git h8300
> 
All three available configurations build fine for me this time.
The allmodconfig build has a couple of failures, but I am not sure
if those are due to upstream failures (the spi build failure is a known
upstream problem). Overall, build looks good.

Compile-tested-by: Guenter Roeck <linux@roeck-us.net>
