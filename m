From: Michal Marek <mmarek@suse.cz>
Subject: Re: linux-next: manual merge of the kbuild tree with Linus' tree
Date: Mon, 12 Sep 2016 11:03:08 +0200
Message-ID: <e1cd32fd-6db2-0dc7-43c4-f678582326ad@suse.cz>
References: <20160912113224.792b24f0@canb.auug.org.au>
 <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160912125341.0596ed9f@roar.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2016-09-12 04:53, Nicholas Piggin wrote:
> Question, what is the best way to merge dependent patches? Considering
> they will need a good amount of architecture testing, I think they will
> have to go via arch trees. But it also does not make sense to merge these
> kbuild changes upstream first, without having tested them.

I think it makes sense to merge the kbuild changes via kbuild.git, even
if they are unused and untested. Any follow-up fixes required to enable
the first architecture can go through the respective architecture tree.
Does that sound OK?

Michal
