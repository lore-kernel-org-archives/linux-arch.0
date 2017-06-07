From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: RISC-V Linux Port v2
Date: Wed, 07 Jun 2017 14:54:15 -0700 (PDT)
Message-ID: <mhng-754e478f-3805-455a-a09f-8a988219670c@palmer-si-x1c4>
References: <29520.1496820584@warthog.procyon.org.uk>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <29520.1496820584@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org
List-Id: linux-arch.vger.kernel.org

On Wed, 07 Jun 2017 00:29:44 PDT (-0700), dhowells@redhat.com wrote:
> What's the target type for building cross-binutils and cross-gcc for it?

riscv64-unknown-linux-gnu

We have a super-repo that scripts the build, and includes a handful of patches
that fix GCC and binutils bugs that are in our first releases.

  https://github.com/riscv/riscv-gnu-toolchain
