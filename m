From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 01/36] asm-generic/io.h: move
 ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
Date: Wed, 20 Dec 2017 18:10:50 +0800
Message-ID: <201712201748.C4nCizdE%fengguang.wu@intel.com>
References: <d25ea659bc370a6bb24c4d42416f890a34051df1.1513577007.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d25ea659bc370a6bb24c4d42416f890a34051df1.1513577007.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com, green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greentime,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on v4.15-rc4 next-20171220]
[cannot apply to linus/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Greentime-Hu/Andes-nds32-Linux-Kernel/20171220-155937
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/io.h:25:0,
                    from arch/openrisc/kernel/asm-offsets.c:35:
>> arch/openrisc/include/asm/io.h:38:29: error: conflicting types for 'ioremap'
    static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
                                ^~~~~~~
   In file included from arch/openrisc/include/asm/io.h:32:0,
                    from include/linux/io.h:25,
                    from arch/openrisc/kernel/asm-offsets.c:35:
   include/asm-generic/io.h:864:15: note: previous declaration of 'ioremap' was here
    void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
                  ^~~~~~~
   include/asm-generic/io.h:865:25: error: conflicting types for 'ioremap_nocache'
    #define ioremap_nocache ioremap_nocache
                            ^
>> arch/openrisc/include/asm/io.h:44:29: note: in expansion of macro 'ioremap_nocache'
    static inline void __iomem *ioremap_nocache(phys_addr_t offset,
                                ^~~~~~~~~~~~~~~
   include/asm-generic/io.h:865:25: note: previous definition of 'ioremap_nocache' was here
    #define ioremap_nocache ioremap_nocache
                            ^
   include/asm-generic/io.h:866:29: note: in expansion of macro 'ioremap_nocache'
    static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
                                ^~~~~~~~~~~~~~~
   make[2]: *** [arch/openrisc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +/ioremap +38 arch/openrisc/include/asm/io.h

58e0166a Jonas Bonn  2011-06-04  31  
58e0166a Jonas Bonn  2011-06-04 @32  #include <asm-generic/io.h>
9b04ebd1 James Hogan 2012-10-23  33  #include <asm/pgtable.h>
58e0166a Jonas Bonn  2011-06-04  34  
58e0166a Jonas Bonn  2011-06-04  35  extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
58e0166a Jonas Bonn  2011-06-04  36  				pgprot_t prot);
58e0166a Jonas Bonn  2011-06-04  37  
58e0166a Jonas Bonn  2011-06-04 @38  static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
58e0166a Jonas Bonn  2011-06-04  39  {
58e0166a Jonas Bonn  2011-06-04  40  	return __ioremap(offset, size, PAGE_KERNEL);
58e0166a Jonas Bonn  2011-06-04  41  }
58e0166a Jonas Bonn  2011-06-04  42  
58e0166a Jonas Bonn  2011-06-04  43  /* #define _PAGE_CI       0x002 */
58e0166a Jonas Bonn  2011-06-04 @44  static inline void __iomem *ioremap_nocache(phys_addr_t offset,
58e0166a Jonas Bonn  2011-06-04  45  					     unsigned long size)
58e0166a Jonas Bonn  2011-06-04  46  {
58e0166a Jonas Bonn  2011-06-04  47  	return __ioremap(offset, size,
58e0166a Jonas Bonn  2011-06-04  48  			 __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI));
58e0166a Jonas Bonn  2011-06-04  49  }
58e0166a Jonas Bonn  2011-06-04  50  

:::::: The code at line 38 was first introduced by commit
:::::: 58e0166a4772aaeb10c9b0f6d59f19099d2047df OpenRISC: Headers

:::::: TO: Jonas Bonn <jonas@southpole.se>
:::::: CC: Jonas Bonn <jonas@southpole.se>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNYzOloAAy5jb25maWcAlDzLctu4svv5ClbmLmYWSfxKxqlbWUAgKOGIIBkAlGRvWIrM
JKrYkkuSZyZ/f7tBUuKjIZ+7mImFbjSARqNfaPD3334P2Mth+7Q8rFfLx8dfwfdyU+6Wh/Ih
+LZ+LP83CNMgSW0gQmnfAXK83rz8+377XG526/0quHl3efPu4u1udR1My92mfAz4dvNt/f0F
SKy3m99+/42nSSTHRZqJREvDP/9qWniWFyP4VyShZMmpXan89EPPjVDFWCRCS16YTCZxyqcA
/z3oYCz4ZMzCsGDxONXSTlSw3geb7SHYl4eGVkNlMhdyPLGnQZK0kGmWalsolp2arWZcFFJ/
iWI2NoXJM8Q5wRt63OTq1BqKqP4rlsZ+fvP+cf31/dP24eWx3L//nzxhShRaxIIZ8f7dyjHr
TdMXxirmqcb1Aed+D8ZuLx5xES/PJ16OdDoVSZEmhVGt+cpEWuDmrGAaB1fSfr6+OnJbp8YU
PFWZjMXnN9vd5c+3j7iXb9+ceFmDCyuMJRgIrGfxTGgj0+TzmzdUc8Fym3aYwfLYFpPUWFz5
5zd/bLab8s/WmObOzGTG28MdYVlq5KJQX3KRC2I+1ZqUUKm+K5i1jE9OQ0cTloSw1Jao5EbE
ckSOxHKQ7zbE8R/2I9i/fN3/2h/KpxP/m43H7cp0OhJDmUCQmaRzGsInsr1v0BKmisnWIagm
XzcjxglkMqaN6LYdRRFPh5iJxJpGhuz6qdztqWVYyacgRALm2T0Mk3uUBJUmbeZBYwZjpKHk
xFZUvWTF8HZbhwQcO5B9AyMrEJcBu0EjvLfL/c/gAHMOlpuHYH9YHvbBcrXavmwO68333uRR
hTDO0zyxMhm3hxqZELeGCxAQwLDkpltmpsYyO5yJ5nlgKI4ldwXAOvqH54VYAGuoE2Mq5HZ3
0+vvJoFUyCkidZhiHNc74kVKhAgLI8Z8hGqHRBvlMg5B5SZX9GmT0+oP8uRj9whEWkb28+VN
055pmdhpYVgk+jjXLbUy1mmeGXJQPhF8mqVABiXDplqQaKg8QPBhP0mwATKh0z1uKBrnzkQG
NFKmBWdWhDQrRczuCAaM4il0nTkdq8OuztVMAWGT5poLVIsnYmExvpcZQQ4gI4BctQxdWMT3
inUaFvc9eNr7fdOyphxMLJwreS+KKNV4VuEfxRLeUYF9NAN/UHJ7Z7iNT9RZAqpdJmkoTFtH
zUSRy/Dy46ltlEWnH9WxOP3u4SqwDBJ0sm5P0IyFVXAk3BRA7unJIb8reKevm/WZnpU9qbRP
u+MU0M2dMlQXJ+GtBebj1gLjCM6lbum8EZj1IsrjFu+i3IpF72eRyfb4IkvplcpxwuIo7OgL
nH1ES6/T/B4Y7Mw5nk7AjLaHYTIl0Fg4k7DAmk6Hh7iRzth3x2/2WqgR01p2NxsaRRh6jmLG
Ly9uBpq59jKzcvdtu3tablZlIP4uN2AlGNgLjnYCzF1lTio6M1XxpXB2omd3Oq4Ps+BaTWnl
ETPacTBxPqL4GaejlsmG3sACPRaNR9QTWwsubMgsK8CNkpEE/SQ9uh6MWiRjsHYk1B3Jjzcj
cARZDMKDSpGjESSm6HCZ5pPK0Z2k6bSnKcDwgG7WqRUcFDNBwk7AOUESctZWDCoN8xjMPIiE
OyKoVE/QbGzZCHybGHYFROiqN3s3owkzE9pGGQZHEGx6JultBI8A/A4RARMlbnoU0ft9GmsG
Tn+1VNozRBzUmSkcxWIqdCJiCDoW/y/kZtv9nWDFMAnw4ex/NUYLveK2F11jPJIjJ/Luya8i
DJ7O3n5d7iHc+1mdrOfdFgK/ytcajon4tQwC+7oEu7xtXNJQMThcE6FhNyhLCAtAjdiWH6dE
jULtftGTqbaE1gsHM8bR+2C0Gqmx8uQcRh290KJSUwDH7RjkeBbeYEr6dNZgVDW6dyZP6l1L
BZOFoxMW075NOilz9PMJbkJ4LBPh4mS3YvCRO3FCDdeChTX8HIzsO4fwWvg6t4F17+OcIy3E
vdADEcx221W53293weHXc+X2fyuXh5dduW+lD/TltLi8urg4DdlkFJxfC651EdpRFdju109v
6ojicbnfB1IGcrM/7F5WmJPYD5MSlcTKxKC+uCSGaMHj83Bwas7CQzlrRUgaFZb5fHnUyffF
pVtjO+y6+nBBH7P74vrCCwI6F5TWv/8MkL7nPNEYT5HujxAqs6BTk44f2bTP0hh0C9N3HmPl
sAi6Ucxs5XG0Ggp0MNFV6OZhHPPQgeiKHKj5UZrant/ikOt24HiUOqKUhc5isJKZdaLqduEY
1ThfgKMSb9k0Odasbjqtb3IHpigMdWErq0tyYWqobFSTGlFofhTaUaDz+ebi08ee2p0ziObB
1IKRmjMqmHChH3jazvhNO9zgsYAIgMEe09ZSMbL9PktTWsPdj3Jaid47fZ16IkvMZWQM3B90
NaY+7wXWgEsYhOT90wQ7bzKIXXQRmpZnzVWISghDMHf4w/Lry/fvYMmC7XPv4P8nV1mRZylq
ySrVEkK0wkXW3+HjmAJGO2JgFFBFrgNtJv4tVy+H5dfH0uVPA+elHlpDQ/wdKYt+USeO6IYR
+KsIcZKNmKAfNQHVXEUuXVqGa5nZwSlgae5JBFTdFKyLyqrB2Dh066QJ22STkvLwz3b3k2Qq
nJmp6EyjagGdx6ikQp7IRSeCgN8D3JNhjGlTuIi0csEHnTcQ6E9REb1MunOVWRWQcuZJnwAC
hD8YUIeFBtZ6RgS0LKEzEDgZmclzwDHuu1A57ctVOIXNE3AQPUmOBDYwnUpPogQp5OFZEogS
pXQ6CplWMI9rjjBh6NXJauqoWf1wt5VnZuaQXoM7IgoNCeiaxGDK/r9C/q/JjoQ4Q9Ej65Zn
sC/J+ChCnZC+AY4krT+PCDx/FWUujJ2nKa2lj1gT+OsVDPM6yt0opg3IEWUmxszj6DYoyew8
HFMNGDCex4pfmetMJOl5jDvhEewjhozBvqTylfWE/FXG8dCj446CMKLC7cYWQChF3LE0nT+/
2ZWb7ZsuVRV+8EUlMpt99CkCvIwqjAA/wZMXQZHPLAwcM2NkRLuBDSFwl1z6Cgy8ynxOACBD
cHlGu4bcw16AGW5pmA49u+a7egL3lGyPrzwjjLQMx5Sj6WyxUw2GtU993UQSm8UsKW4vri6/
kOBQ8MSjhOKYX3m440knWBbTe7u4+kAPwTI6F5ZNUt+0pBAC1/PhxitGLhKhl8vp8UawSQwd
Z1qDoO82M3NpOX2uZwYvy6zXUMJhn/r9EZV5HBJcS+JJX02M302pZhoKejGIEV9DYGTgaBTn
sBJuJCGGCNILTJ7dFZhubnmRX+Keexccyv2hlwJyJ31qx4LOS06Y0iyUtI7ljO408iTEIpip
9h3MqJhy+mwaqwVThbsfpfk8l3j17km9zKVinhxaNJWelA+y5ROtETiTEQ0Q2aTw3UQnkecu
3IDS9FhB51xFNCyen3FtQmMLf3g41inMNT4j5yCHeEoIcVPszuV/a4xGwMLy7/WqDMLd+u8q
TX+qc1iv6uYg7UcWeZXAn4g4cxcIVDNsu520qhJgYKuyyLQNZdUCblyetK6lwBwlIYuHGQ5H
PZJazRm45e76lORENHfpR0HZbAyK5+7qsBVXtRQ5RpKhljOPwNYIYqY9Dn2FgAUbNRnwDlQ6
83hLiMYgRuANsitf8EQSBhw8YOxMGjL5f6w5gJAdJih5NzuLeV8zAcaFeCscEYm/0cs+eHDy
0LmvgX+SwYXDSe1a6noptK3CojTqRPARBpbWU9ICUMw8geIQbQKFYDq+o0GYpwEV0mnrJErh
dxVbnn4r0Iy9ScEe6d5dcytu1v24xXFIYckVwTIQK3WHkyCpiYTHqclBhA3upvcOXTNarfIr
cjJCgPCoYP/y/LzdHdrTqSDFp2u++DjoZst/l/s6H/vkLu72P5a78iE47JabPZIKHtebMniA
ta6f8c82aSsLM5wKezyUu2UQZWMWfFvvnv4BgsHD9p/N43b5EFTFV42ukZtD+RgoCKNQ/iqN
08AMB409bJ6lGdF6IjTZ7g9eIF/uHqhhvPjb52NC3ByWhzJQy83ye4m8Cv7gqVF/9tUnzu9I
7rQLfOKxxovYXbF4gSzKG/2Q+so2AK1nweqlgfNRSWhLMhoJAyDG0J3LT2wLPXlIB6w9Mdql
OSmeRj9I2UlcNffzJ58jTUJf7OHOEX2GvuQslvdnskxWeI6PYhzdedoFXfgg0AviLt9o8JdJ
/c5Av5yg68SlrpoosRr+8CwIXAZfezFzXHWld54ZzISl3d8k7pUwVfKKftLp9D90hTtcg6ZY
f33BilTzz/qw+hGw3erH+lCu8I6ohd5slZ3gBartigHY8jDVYI4ZxzsqVyl48ikx3mSFNVT8
1u6t2H37UqANAgFJrGQ0UPN+5NdAcp1q5hmVg0/Rq98BsaDKDVoURxpcEZ52rgFGN3TYNeIK
rTjthVdlCd78WdjrN5yJuK/rHE+nyLUUSQY+GEvYWCj0sPozGFKa5GwuJMlamVgR05Dbqw+L
BQlSTM9Et3ZIzZQvelEo8awYUbc4baKSa9GhOTW3tx8uC0VW3LR6JgwkT9Hrgz91mqRKkNDb
60+tG1GQ/JSTeKi9sICwPbsv0FAIECg65FGv7oqGjTPMkANqDK01CYI4xuTdak2zGI9E0dMa
RE8hvtAk05hpcNY0zSVjcW86Dhg0wcpfH3ImOzkb+FnoiUw8ek9iAU+ccmmpG4cW2bm8710/
VC3F/MOl50r3iHBN3uu2l3uXgNm+63rjc14s4nFvtxsBB8mvXfiWIcXGUd6tuHBtHAsUpE9w
KhxpR8xjZBvChcoXxTjzHbo2llISrPgZchMJjkLUF+bGm57cgavSivfm0NIEpOAvBPCz8VlO
1uRkHFSIJOhkRK31/Qj29uJ64QUDL/9aLM7Cb/86B6+VvReBSzAi/umBc2Rl4oeHDITiDPkw
u72+vbk9D//4Vx/exM1yIRxvO/dwPIth230Unb4vFnN250WJQRaEvby4vOR+nIX1wmrr8Cr8
8mLsWVhlCvorc0rIGUAvZcRAU+DFSFhdW+ZD+HK2uxbo6kz9cFDbZ2dolPEzFfyFy4uF5+4D
HCzQUZL7t3YGfpkxwgtfYN0jqAw4slca/0/Hzpmn/DvuXry6I46R29v9+qEMcjNqAhaHVZYP
+AQKgjCENHlR9rB8hlCTCnrnPU++ipE3rhJgvsbM4h/Dy/M/g8MWsMvg8KPBIjTQ3BMjSBMO
h5Sb55fDMARrHaAsH0bQE4hSXdQs36cBdulMwODDDzpFyJQgswMcgvrlCnl1ylc0omA7x2JG
uRlYC/AJ9IrtmrFYjBm/c830JsNE4XAkEB65pJ6mE3ZJMTZ0sFa9+TJ0vAkmsldtBC1TaBqG
weVuvXwcxib1/Fx2ibcjiRoALusF2dh6t1DXl3b40saMUEVS028j1QEkPVaii5xp26qIakM1
vrZR4ohCTkIsLDgjnvucNiIzGZYvzZDaq8iR8VQ9tBk1fxVF26vb24WfQ2lUZDGz+H7ieDGy
3bzFvoDtdtbpCeJ01RRwNTGoM/8Y3XqfVmNra/pUDeeJR73WGHUg+x/Lxq8xtEZ9Da1WuhCx
vUpQ0w5hDYa9K+LsNSLwSyzApSpCOQbPI/ZkgWtsTKuDj0ifZHtXP96gdWcGZrIq/aKHmMwL
sFhhSusJff3p4/BxQsYVlyxYEbrvNC8O/2U0VWB2fNdbUKXUrzipyz0vuYynOt7AounFGp8x
Hc4ls1mwetyuflIzwlqAyw+3t9VLRJ89rDxyV+rrrQ1oGcblw8MazSWcOzfw/l3rLSYEEB3v
Hg4vtg1vWbyhBgKqR0XDhHv5tN39Cp6Wz8/gDTgKhH12BP66WVSBin+M6sj54eHcd7PuwJHF
fy4u6fjQoTR3Mo36OoOpz/NDwfZ5HtI5eKUXhgyLwopN5b/PsL19R+aSlrJ0LnTBZvRBrqBa
GE+eqoLj6+yY9hsnc9/DScwUKkbblDnD2/iUKuYyZoRPyYwcOTVdWfztZr3aB2b9uF5tN8Fo
ufr5/LjsXl5AP4IaxHisTa4d/LEhg18eD+tvLxtXyn4maoWNcOaEjjMAiPXXoJVjseAeHXfC
msQ89ET7gDORH2+uLosMby9I/lsQSGYkv/aSmAqVeS5XEazsx+tPf3nBRn24oCWLjRYfLi7O
MwIfs3nkA8FWFkxdX39YFNZALO1ng/WdfS3GOZxH34WmCCVrPi4w2O7xbvn8AwWL0LWhHjqe
jGfBH+zlYb0N+Pb4suLPwVcZ2kTwIoewdQ4r2i2fyuDry7dvYM3CoTWLfJU5fBrjRxYKkBxq
cSfvf8yw3ttzB53mCXXdCyFZkU64hJlbG4vBJyQQPvhcAzYe3zFNeOcWKjfDqyxsoy4ksD37
8WuP38sI4uUvNPPD84ejeYP4NHPwBReSruNBqFOzM5974zBYOBZDmXET3P7jNuwRJ/bLWVr7
67l8y31zzeNMen2pfE5vs1Ke4yCU6T8oOa1ezCGO89TjVa8V5Qisi/WkKCyvqg3phJNi9ZXg
gC0AGuVRq2z9JGZYEIEv2ugp5YtQmsx3V597Tv1M6qYkYziX2XoHs6D2Aruh+e0pk/r6f7Xb
7rffDsEE9nL3dhZ8fyn3ZBxSVW6gysJnF55sDRt735HOm0+tDAN75/qZ7cvOky51FiPzvIUx
k+oBc8HVKwjK5nQh4xHDKrpIXagaAWTQk8CT8SilAkCZKpW3VEenOskBg2z5vazed5gj26tv
RoCveCjx8p5iC1blWKyL4AOO6uen/fe+ljGA+Idx358I0k3Af6yf/wz2z+Vq/e1YKHVEZk+P
2+/QbLa8T2e02y4fVtsnCrZ+pxZU+5eX5SN06fc57UCeLKS/XgSmXng4nymM2SItPJUqC+s1
xe4rL3Qo5zmB2Zy6sZP6S/fzKwwsIMSaIBWLItGnt3juyWEmOze3El+0eNWk81Ffu1qP1FAC
0FC0PzdycrUbf95/P1BM04ShCr/yYmFslS1YcXWbKAz1PAWGbSyk5/e2OaMjA+Up1NVsqALZ
5mG3XT90VEcS6lR6aoA9pZnJrJd/a+k3ur26QfBUKLgSooETBNExoWOjbtBcoeKbr2ofu36S
qT8+wTh1GSwWqHCiTk6vaase+/YrcRq6+A4b4dX3b44KLgnR4bzrw9vzEQnXd1n/QwNHeJJa
GXUStWHVRJ2pClL0P+YRsWGXI/BLnlo6GHYQbum4DD/yEpmbwvOuP8KiUw+sLrkriECfL1c/
ep6tGRTGVmd1X748bP+vsWtpbhuHwff9FT7uzux2YiftZg89yJIcq5YlhbLiJBdP6noSTxs7
Yzuz23+/AEi9SIDuKTEBUXxAIAgCHym5r53n+uMA9b7qzyIVzewNSJdoY61QISVLwrY1gVl0
qgP9lUYq5uYNsQO6Ma/k1mh/1hGx7Q6YAmJZ0bR47jEUkjcWKrBC0/FKtDT0H6hjwokwpiGS
nOqAk17zctiW3MTOk+1wOIhBjZGp3Ur9emsiVdj/fTeyfl/2InaoRBwhIguZDQhVsxT0JRC5
7c0NHUJotK22VfgV2z/hrf1mN7hd7VKtit4Spku0T4yfLYxOF8Y7TARCFhbiM3kUSLRAntos
db/ScrN+P2xPPzkjfhaLZ0JhpWA3AXuDuKRFmnAzvLxeotBg3MbCUo06EPMEdVQ6M7t1vlbb
rqATtGNTOxHtpK7z2ioNDz/fTvvBen/YDPaHwcvmxxvFf/aYEQ8xKDqRRb3ikVseB9HnV6bQ
ZR2nszApprFySYje4tSChS6rgmXJ5oQylrHBznEaKLZkVhRMJzELddRLkzfvELKxDDniTQZD
jcOIiyUyVB3uppymm3KuNXZOM/vgCramhKaD8e0lU8vNZDi6nlec0WE4MkSrstuFhe7IoUol
MEbmRfSHt93qJp9ngcV9CnaJj8UO5NfG5PvpZbNDCFMME413a/w40EH67/b0MgiOx/16S6To
6fTUSzYwjRcyiupB9JPDKVgKweiiyNOH4eUFnzVneMv4tu/zsaVoGiRZcgcTordvtNt+3X+z
ciTMi8feoQqFBbshCwq7bgpvzBtyqviDVkMuzrTt3v9y0OZLFTABG0/HF3k4+PivWgEBFYbV
aciZht5ZlZqg5OfN8cQ1QYWXwqFcl+MMw2J4EUm5Y0YiRYSsevx/QRbnEW+zNGT/0wnIKuyk
JLd/rVTnEWigcxyf+EOtlmP0kU9SbjkuR946ymkwlIUDqPAGRjyA8HHonS/g4A82aoV1o4b/
eGtYFtYrtGBt3156wSPNcszp+YBgVb26NavGQu56zaFCr0DARnQ5SfxyFwbzOE0T70KKEBte
0UIG73RHQg6TIU/or1e/TINHAQ6sntYgLQO/SNV636/vhSCYhq4KCxnNXfG8owkbHXtStPzs
X98Om+PROvBpRhCT24T9mtHwj0L+kCZfX3mFOn30yhKQp4wr9Gn3bf86yN5fv24OBv7aPrFq
xLlMVmGhMu6Etu6kGqPnMKsc+4YotCK4n5KmWfrVZXHq/IJZhghzp/LigVElaNAhcKGMbmgz
lsaw/SVmJfjybT405z2r5JIbkfiO4nfCIJg34w9VwWfozmG4OZzQSQ321pECKI/b5x3huQ3W
L5v1dyuvfJxkgTKhOhOnsnT79fB0+Dk47N9P2103inCcLDBDV5U9Y7SFdWzp3A67BpRfKNi5
PqwmmK9ovFcMSxpnApXwdBZJWrqkIkzwPKGLZNZggEvF/bEPwS4FmRJmNRxKKjJceQ0IeNGi
WnFRl2SbWG24HIGOSidC/qxhSJMwHj9cM49qiqQKiCVQS1kTIYcErBbK61XIRwukydhroYW8
oULo8FqsDE6smTLB241H6f5xA92KKB4GCbLj1Xm8YsvvH7HY/r26v/7klJGHvnB5k+DTlVMY
qDlXtphW87FDQOR5t95x+KU776ZU6HfbNxsAu0PpA2F3CF1A7B5/LpR3Ooyn/vDddTEHsSia
9xJ8MGs9y/NCTHxFBjra5f3x0W03GY3Sx93vPFjkYDTTbHS8ZCoS5CmKBCwcvH6AB44GOZ9E
fZBhg3jIu67wXEdA/GvhZm9WtDkVnF+gv29Yif+tA9v88lTrfyp9O2x3p+8UnfDtdXN85vx6
BmIeT3Q5/aODZRF8nvCEGx/R3417GSQBnekOx1VrJm1/bP6iOwdogTpSg9a6/MC1SQcUIrok
OxhxRi6ZZaCyc3jzhnVeIRCHDShoeCYK7wzB2j4PL0ZX/UEvVkE5X4lAsYjmSm8IhIB3AzUL
FYxzAehD95b13RtEQt10N+SyjAlFE13888CC4an7YLHoUcuz9MGtTiP9LuNgVsNdsu2dB3ic
Wz6UfTyEXlUaY7lJAtNhng1gZE/+UHgonL2UMLl1lcgoQ2BSNUWelHkmZp9TNfn4Syx5Zsyo
IlY12CPScYvmuuPnWxPNnSl4ewE3q2hEdd6F52aTNF8yE9wl+5o8tcApfmsAOgfpfv39/U1/
dNOn3XM/1CCfEEJrhUiYLg555zVIXE2rTN+owTItb9mozs4cZSA4IIw5r9x79NVdkFZxC1Ct
iaim8mrRFmt8XRqFnjqmYlGDENnBQbWe1nIQZ5GrOazhx1bN4tjGXNMWNjoYW6jU349v2x0F
Wf85eH0/bf7bwD+b0/rDhw9/uCqwRe/2TT4TSmTL49lK9JoJ9iR0w8Nmjrr17sksRny1dKgO
4rRAYBR7zWpFZqnbxq5sLRfqLLykpcpwv48AoXLqgFFA+jv3dUW6x8Wom+QcR+lTM3Qwn0i3
IWieUEFfML2VOYrDC2t4falAH4j32ZwdcLzLBu8u8XP8UjWUyyVS49vScwiqBwAUhl5zlLza
1AO5ipUiPIIvekVjmfXZHsujRxWvOQI7ZOHirxF2E8446EQhlpZYRCrG5Jr0NgQTlodujJBH
Mh3jZxQov5WfzYA5i/TaCPZ/WdSlaXyPwFmePmvrUx+5CulAyDcDxkXOBxIRg+uF6NNhJzoX
zvKJXlVC+BJRFTp+FjKWKfVV8g3p+Z8JaYv0cvTwhHnBn17r9heezulAFE/9kX05UmtyxXP/
FJrDcfGQniyfTN+BAlshVTmBSe3iRzh4QjxBC5hejcsgQ6jwrBLAcIijS/kfTbMHAw1xAAA=

--opJtzjQTFsWo+cga--
