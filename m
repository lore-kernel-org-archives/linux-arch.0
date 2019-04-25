From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] csky fixes for v5.1-rc7
Date: Thu, 25 Apr 2019 09:21:01 -0700
Message-ID: <CAHk-=wh8NTGSOerqZNhefEn=AX5kgx27tD+kv=UpOB8u-FeYTA@mail.gmail.com>
References: <1556181403-3881-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556181403-3881-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 25, 2019 at 1:36 AM <guoren@kernel.org> wrote:
>
> Here are the patches which made on 5.1-rc6 and all are tested in our
> buildroot gitlab CI:

This really looks like it should come in the next merge window, not during rc7.

You had absolutely zero csky updates during the merge window, you
can't then magically come up with "look, here's 1300 lines of fixes"
during the late rc series.

Re-send when the merge window opens.

                   Linus
